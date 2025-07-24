from dotenv import load_dotenv
load_dotenv()
import discord
from discord.ext import commands
import json
import os
import secrets
import string
from datetime import datetime
from database import db

BOT_TOKEN = os.getenv('BOT_TOKEN')
if not BOT_TOKEN:
   raise ValueError("BOT_TOKEN environment variable not set")

print("✅ SQLite database connected successfully")

# Bot setup
intents = discord.Intents.default()
intents.message_content = True
intents.members = True
bot = commands.Bot(command_prefix='!', intents=intents)

def save_application(application):
   """Save new application using SQLite"""
   user_id = str(application['user_id'])
   db.add_user(user_id, application['username'])
   db.set_user_data(user_id, 'application', json.dumps(application))

def load_applications():
   """Load all applications from SQLite"""
   users = db.get_all_users()
   applications = []
   
   for user_id, username in users:
       app_data = db.get_user_data(user_id, 'application')
       if app_data:
           applications.append(json.loads(app_data))
   
   return applications

def generate_beta_key():
   """Generate a unique beta key"""
   segments = []
   for _ in range(3):
       segment = ''.join(secrets.choice(string.ascii_uppercase + string.digits) for _ in range(4))
       segments.append(segment)
   return f"VAULT-{'-'.join(segments)}"

def save_unused_key_to_database(beta_key, discord_user_id, issued_by):
   """Save unused beta key to SQLite"""
   user_id = str(discord_user_id)
   key_data = {
       'discord_user_id': user_id,
       'created_at': datetime.now().isoformat(),
       'issued_by': issued_by,
       'status': 'unused'
   }
   
   db.set_user_data(user_id, f'beta_key_{beta_key}', json.dumps(key_data))
   db.set_user_data(user_id, 'current_beta_key', beta_key)
   print(f"✅ Saved key {beta_key} to SQLite")
   return True

def check_key_exists_in_database(beta_key):
   """Check if key exists in database"""
   users = db.get_all_users()
   for user_id, _ in users:
       existing_key = db.get_user_data(user_id, 'current_beta_key')
       if existing_key == beta_key:
           return True
   return False

class BetaApplicationView(discord.ui.View):
   def __init__(self):
       super().__init__(timeout=None)
       
   @discord.ui.button(label='Apply for Beta Access', style=discord.ButtonStyle.primary, emoji='🔐', custom_id='beta_apply_button')
   async def start_application(self, interaction: discord.Interaction, button: discord.ui.Button):
       applications = load_applications()
       existing_app = next((app for app in applications if app['user_id'] == interaction.user.id), None)
       
       if existing_app:
           status = existing_app.get('status', 'pending')
           if status == 'pending':
               await interaction.response.send_message("⏳ You already have a pending application. Please wait for review.", ephemeral=True)
               return
           elif status == 'approved':
               await interaction.response.send_message("✅ You're already approved! Check your DMs for your beta key.", ephemeral=True)
               return
           elif status == 'denied':
               await interaction.response.send_message("❌ Your previous application was denied. Contact an admin if you believe this was an error.", ephemeral=True)
               return
       
       modal = BetaApplicationModal()
       await interaction.response.send_modal(modal)

class BetaApplicationModal(discord.ui.Modal):
   def __init__(self):
       super().__init__(title="Vault Desktop Beta Application")
       
       self.email = discord.ui.TextInput(
           label="Email Address",
           placeholder="your.email@example.com",
           required=True,
           max_length=100
       )
       
       self.why_interested = discord.ui.TextInput(
           label="Why are you interested in beta testing?",
           placeholder="Tell us what interests you about Vault Desktop...",
           style=discord.TextStyle.paragraph,
           required=True,
           max_length=500
       )
       
       self.feedback_commitment = discord.ui.TextInput(
           label="Will you provide feedback if selected?",
           placeholder="Yes/No - Will you report bugs and suggest improvements?",
           required=True,
           max_length=200
       )
       
       self.primary_interest = discord.ui.TextInput(
           label="Primary Interest",
           placeholder="Password Manager, Gaming Auto-fill, or Both",
           required=True,
           max_length=100
       )
       
       self.games_played = discord.ui.TextInput(
           label="Games you play (if any)",
           placeholder="Valorant, Rocket League, Other, or None",
           required=False,
           max_length=200
       )
       
       for field in [self.email, self.why_interested, self.feedback_commitment, 
                    self.primary_interest, self.games_played]:
           self.add_item(field)
   
   async def on_submit(self, interaction: discord.Interaction):
       application = {
           "user_id": interaction.user.id,
           "username": str(interaction.user),
           "display_name": interaction.user.display_name,
           "email": self.email.value,
           "why_interested": self.why_interested.value,
           "feedback_commitment": self.feedback_commitment.value,
           "primary_interest": self.primary_interest.value,
           "games_played": self.games_played.value,
           "timestamp": datetime.now().isoformat(),
           "status": "pending"
       }
       
       save_application(application)
       await self.send_to_admin_channel(interaction, application)
       
       user_embed = discord.Embed(
           title="🎉 Application Submitted Successfully!",
           description="Thank you for applying for Vault Desktop beta access!",
           color=0x4CAF50
       )
       user_embed.add_field(name="What's Next?", 
                          value="• We'll review your application\n• Selected testers will receive a DM\n• Beta invites sent in batches\n• Check announcements for updates", 
                          inline=False)
       user_embed.set_footer(text="Keep an eye on your DMs and #announcements!")
       
       await interaction.response.send_message(embed=user_embed, ephemeral=True)
   
   async def send_to_admin_channel(self, interaction, application):
       admin_channel = discord.utils.get(interaction.guild.channels, name="beta-applications")
       
       if not admin_channel:
           print("Admin channel 'beta-applications' not found!")
           return
       
       admin_embed = discord.Embed(
           title="🆕 New Beta Application",
           color=0x2196F3,
           timestamp=datetime.now()
       )
       
       admin_embed.add_field(name="👤 User", value=f"{application['username']}\n<@{application['user_id']}>", inline=True)
       admin_embed.add_field(name="📧 Email", value=application['email'], inline=True)
       admin_embed.add_field(name="🎯 Primary Interest", value=application['primary_interest'], inline=True)
       
       admin_embed.add_field(name="🎮 Games", value=application['games_played'] or "None specified", inline=True)
       admin_embed.add_field(name="🔄 Feedback Commitment", value=application['feedback_commitment'], inline=True)
       admin_embed.add_field(name="📊 User ID", value=application['user_id'], inline=True)
       
       admin_embed.add_field(name="💭 Why Interested", value=application['why_interested'][:1000] + ("..." if len(application['why_interested']) > 1000 else ""), inline=False)
       
       admin_embed.set_footer(text=f"Application ID: {application['user_id']}")
       
       view = ApplicationReviewView(application['user_id'])
       await admin_channel.send(embed=admin_embed, view=view)

class ApplicationReviewView(discord.ui.View):
   def __init__(self, user_id):
       super().__init__(timeout=None)
       self.user_id = user_id
       
   @discord.ui.button(label='✅ Approve', style=discord.ButtonStyle.success, custom_id='approve_application')
   async def approve_application(self, interaction: discord.Interaction, button: discord.ui.Button):
       # Update application status
       applications = load_applications()
       for app in applications:
           if app['user_id'] == self.user_id:
               app['status'] = 'approved'
               app['reviewed_by'] = str(interaction.user)
               app['reviewed_at'] = datetime.now().isoformat()
               save_application(app)
               break
       
       # Update embed
       embed = interaction.message.embeds[0]
       embed.color = 0x4CAF50
       embed.title = "✅ APPROVED - Beta Application"
       embed.add_field(name="👨‍💼 Reviewed By", value=str(interaction.user), inline=True)
       embed.add_field(name="⏰ Reviewed At", value=datetime.now().strftime("%Y-%m-%d %H:%M"), inline=True)
       
       self.clear_items()
       await interaction.response.edit_message(embed=embed, view=self)
       
       # Assign Beta-Tester role
       try:
           member = await interaction.guild.fetch_member(self.user_id)
           
           if member:
               beta_role = discord.utils.get(interaction.guild.roles, name="Beta-Tester")
               if not beta_role:
                   beta_role = discord.utils.get(interaction.guild.roles, name="beta-tester")
               if not beta_role:
                   beta_role = discord.utils.get(interaction.guild.roles, name="Beta Tester")
               
               if beta_role:
                   await member.add_roles(beta_role)
                   role_msg = f"✅ Assigned {beta_role.name} role"
               else:
                   role_msg = "⚠️ Beta-Tester role not found"
               
               await interaction.followup.send(role_msg, ephemeral=True)
           else:
               await interaction.followup.send("⚠️ User not found in server", ephemeral=True)
               
       except discord.NotFound:
           await interaction.followup.send("⚠️ User not found in server - they may have left", ephemeral=True)
       except Exception as e:
           await interaction.followup.send(f"⚠️ Role assignment failed: {str(e)}", ephemeral=True)
       
       # Auto-generate and send beta key
       beta_key = None
       for attempt in range(5):
           test_key = generate_beta_key()
           if not check_key_exists_in_database(test_key):
               beta_key = test_key
               break

       if beta_key and save_unused_key_to_database(beta_key, self.user_id, str(interaction.user)):
           # Update application with key info
           applications = load_applications()
           for app in applications:
               if app['user_id'] == self.user_id:
                   app['beta_key'] = beta_key
                   app['key_issued_at'] = datetime.now().isoformat()
                   app['key_issued_by'] = str(interaction.user)
                   save_application(app)
                   break
           
           try:
               user = await bot.fetch_user(self.user_id)
               dm_embed = discord.Embed(
                   title="🔑 Your Vault Desktop Beta Key",
                   description=f"```{beta_key}```",
                   color=0x4CAF50
               )
               dm_embed.add_field(
                   name="📥 Download Vault Desktop", 
                   value="[**Click here to download →**](https://getvaultdesktop.com/#download)", 
                   inline=False
               )
               dm_embed.add_field(
                   name="📋 Quick Start", 
                   value="1. Click the download link above\n2. Run the installer\n3. Enter your beta key\n4. Start testing!", 
                   inline=False
               )
               dm_embed.add_field(
                   name="🚨 Important", 
                   value="• Keep this key private\n• Valid for one installation only\n• Report bugs in #beta-feedback", 
                   inline=False
               )
               dm_embed.set_footer(text="Need help? Ask in #beta-support")
               await user.send(embed=dm_embed)
               await interaction.followup.send(f"✅ Approved and beta key `{beta_key}` sent to <@{self.user_id}>", ephemeral=True)
           except:
               await interaction.followup.send(f"✅ Approved but couldn't DM <@{self.user_id}>. Beta key: `{beta_key}`", ephemeral=True)
       else:
           await interaction.followup.send(f"✅ Approved but failed to generate key for <@{self.user_id}>", ephemeral=True)
   
   @discord.ui.button(label='❌ Deny', style=discord.ButtonStyle.danger, custom_id='deny_application')
   async def deny_application(self, interaction: discord.Interaction, button: discord.ui.Button):
       modal = DenialReasonModal(self.user_id)
       await interaction.response.send_modal(modal)

class DenialReasonModal(discord.ui.Modal):
   def __init__(self, user_id):
       super().__init__(title="Application Denial")
       self.user_id = user_id
       
       self.reason = discord.ui.TextInput(
           label="Reason for denial (optional)",
           placeholder="Not meeting requirements, too many applicants, etc.",
           style=discord.TextStyle.paragraph,
           required=False,
           max_length=500
       )
       self.add_item(self.reason)
   
   async def on_submit(self, interaction: discord.Interaction):
       applications = load_applications()
       for app in applications:
           if app['user_id'] == self.user_id:
               app['status'] = 'denied'
               app['denial_reason'] = self.reason.value
               app['reviewed_by'] = str(interaction.user)
               app['reviewed_at'] = datetime.now().isoformat()
               save_application(app)
               break
       
       embed = interaction.message.embeds[0]
       embed.color = 0xff4757
       embed.title = "❌ DENIED - Beta Application"
       embed.add_field(name="👨‍💼 Reviewed By", value=str(interaction.user), inline=True)
       embed.add_field(name="⏰ Reviewed At", value=datetime.now().strftime("%Y-%m-%d %H:%M"), inline=True)
       if self.reason.value:
           embed.add_field(name="📝 Reason", value=self.reason.value, inline=False)
       
       view = ApplicationReviewView(self.user_id)
       view.clear_items()
       
       await interaction.response.edit_message(embed=embed, view=view)
       
       try:
           user = await bot.fetch_user(self.user_id)
           dm_embed = discord.Embed(
               title="Beta Application Update",
               description="Thank you for your interest in Vault Desktop beta. Unfortunately, we cannot accept your application at this time.",
               color=0xff4757
           )
           if self.reason.value:
               dm_embed.add_field(name="Feedback", value=self.reason.value, inline=False)
           dm_embed.add_field(name="Stay Updated", value="Keep an eye on our announcements for future opportunities!", inline=False)
           await user.send(embed=dm_embed)
       except:
           pass

@bot.event
async def on_ready():
   print(f'{bot.user} has landed! 🚀')
   print(f'Bot is ready in {len(bot.guilds)} server(s)')
   
   for guild in bot.guilds:
       print(f"Loading members for {guild.name}...")
       await guild.chunk()
   
   bot.add_view(BetaApplicationView())
   bot.add_view(ApplicationReviewView(None))

@bot.command(name='setup_beta')
@commands.has_permissions(administrator=True)
async def setup_beta_channel(ctx):
   """Post permanent beta signup embed (Admin only)"""
   embed = discord.Embed(
       title="🔐 Vault Desktop - Beta Testing",
       description="**Help us test our secure password manager**\n\nWe're looking for testers to help improve Vault Desktop before public release.",
       color=0x4CAF50
   )

   embed.add_field(
       name="🧪 What We Need Tested",
       value="• Password storage and encryption\n• Valorant auto-fill feature\n• Account recovery system\n• Overall app stability\n• User interface feedback",
       inline=False
   )

   embed.add_field(
       name="📋 Requirements",
       value="• Windows 10/11 (64-bit)\n• Willing to report bugs\n• Provide feedback on Discord\n• Test regularly during beta period",
       inline=False
   )

   embed.add_field(
       name="🎯 How You Help",
       value="• Try to break things (safely!)\n• Report any crashes or errors\n• Suggest improvements\n• Test the Valorant auto-fill\n• Share your experience",
       inline=False
   )

   embed.set_footer(text="Limited beta spots • Applications reviewed daily")
   
   view = BetaApplicationView()
   await ctx.send(embed=embed, view=view)
   await ctx.message.delete()

@bot.command(name='generate_key')
@commands.has_permissions(administrator=True)
async def generate_beta_key_command(ctx, user: discord.Member = None):
   """Generate beta key for approved user"""
   if not user:
       await ctx.send("❌ Please mention a user: `!generate_key @username`")
       return
   
   beta_role = discord.utils.get(ctx.guild.roles, name="Beta-Tester")
   if not beta_role:
       beta_role = discord.utils.get(ctx.guild.roles, name="beta-tester")
   if not beta_role:
       beta_role = discord.utils.get(ctx.guild.roles, name="Beta Tester")
   
   if not beta_role or beta_role not in user.roles:
       await ctx.send("❌ User must have Beta-Tester role first")
       return
   
   beta_key = None
   for attempt in range(5):
       test_key = generate_beta_key()
       if not check_key_exists_in_database(test_key):
           beta_key = test_key
           break
   
   if not beta_key:
       await ctx.send("❌ Failed to generate unique key after 5 attempts")
       return
   
   database_success = save_unused_key_to_database(beta_key, user.id, str(ctx.author))
   
   if not database_success:
       await ctx.send("❌ Failed to save key to database")
       return
   
   # Update applications
   applications = load_applications()
   for app in applications:
       if app['user_id'] == user.id:
           app['beta_key'] = beta_key
           app['key_issued_at'] = datetime.now().isoformat()
           app['key_issued_by'] = str(ctx.author)
           save_application(app)
           break
   
   try:
       embed = discord.Embed(
           title="🔑 Your Vault Desktop Beta Key",
           description=f"```{beta_key}```",
           color=0x4CAF50
       )
       embed.add_field(name="📥 Download", value="[Get Vault Desktop](https://getvaultdesktop.com/#download)", inline=False)
       embed.add_field(name="📋 Instructions", 
                      value="1. Download and run Vault.exe\n2. Enter this key when prompted\n3. Create your vault account\n4. Start testing!", 
                      inline=False)
       embed.add_field(name="🚨 Important", 
                      value="• Keep this key private\n• Valid for one installation only\n• Report bugs in #beta-feedback\n• Sharing keys = permanent ban", 
                      inline=False)
       embed.set_footer(text="Need help? Ask in #beta-support")
       
       await user.send(embed=embed)
       await ctx.send(f"✅ Beta key `{beta_key}` generated and sent to {user.mention}")
       
   except discord.Forbidden:
       await ctx.send(f"⚠️ Couldn't DM {user.mention}. Beta key: `{beta_key}`")

@bot.command(name='applications')
@commands.has_permissions(administrator=True)
async def view_applications(ctx, status='all'):
   """View beta applications (Admin only)"""
   applications = load_applications()
   
   if not applications:
       await ctx.send("No applications found.")
       return
   
   if status != 'all':
       applications = [app for app in applications if app.get('status', 'pending') == status]
   
   embed = discord.Embed(
       title=f"📊 Beta Applications ({status.title()})",
       color=0x2196F3
   )
   
   total = len(applications)
   pending = len([app for app in applications if app.get('status', 'pending') == 'pending'])
   approved = len([app for app in applications if app.get('status') == 'approved'])
   denied = len([app for app in applications if app.get('status') == 'denied'])
   
   embed.add_field(name="📈 Total Applications", value=str(total), inline=True)
   embed.add_field(name="⏳ Pending", value=str(pending), inline=True)
   embed.add_field(name="✅ Approved", value=str(approved), inline=True)
   embed.add_field(name="❌ Denied", value=str(denied), inline=True)
   
   password_interested = len([app for app in applications if 'password' in app.get('primary_interest', '').lower()])
   gaming_interested = len([app for app in applications if 'gaming' in app.get('primary_interest', '').lower() or 'both' in app.get('primary_interest', '').lower()])
   
   embed.add_field(name="🔐 Password Interest", value=str(password_interested), inline=True)
   embed.add_field(name="🎮 Gaming Interest", value=str(gaming_interested), inline=True)
   
   await ctx.send(embed=embed)

@bot.command(name='revoke_key')
@commands.has_permissions(administrator=True) 
async def revoke_beta_access(ctx, user: discord.Member):
   """Revoke beta access for a user"""
   user_id = str(user.id)
   
   # Find and revoke user's beta key
   applications = load_applications()
   user_key = None
   
   for app in applications:
       if app['user_id'] == user.id:
           app['status'] = 'revoked'
           app['revoked_at'] = datetime.now().isoformat()
           app['revoked_by'] = str(ctx.author)
           user_key = app.get('beta_key')
           save_application(app)
           break
   
   # Update key status in database
   if user_key:
       key_data = db.get_user_data(user_id, f'beta_key_{user_key}')
       if key_data:
           key_info = json.loads(key_data)
           key_info['status'] = 'revoked'
           key_info['revoked_at'] = datetime.now().isoformat()
           key_info['revoked_by'] = str(ctx.author)
           db.set_user_data(user_id, f'beta_key_{user_key}', json.dumps(key_info))
   
   # Remove Beta-Tester role
   beta_role = discord.utils.get(ctx.guild.roles, name="Beta-Tester")
   if not beta_role:
       beta_role = discord.utils.get(ctx.guild.roles, name="beta-tester")
   if not beta_role:
       beta_role = discord.utils.get(ctx.guild.roles, name="Beta Tester")
   
   if beta_role and beta_role in user.roles:
       await user.remove_roles(beta_role)
   
   if user_key:
       await ctx.send(f"✅ Beta access revoked for {user.mention} - Key `{user_key}` invalidated")
   else:
       await ctx.send(f"✅ Beta access revoked for {user.mention} - No active key found")

@bot.command(name='check_keys')
@commands.has_permissions(administrator=True)
async def check_database_keys(ctx):
   """Check beta key statistics"""
   users = db.get_all_users()
   
   unused_count = 0
   used_count = 0
   revoked_count = 0
   
   for user_id, username in users:
       current_key = db.get_user_data(user_id, 'current_beta_key')
       if current_key:
           key_data = db.get_user_data(user_id, f'beta_key_{current_key}')
           if key_data:
               key_info = json.loads(key_data)
               status = key_info.get('status', 'unused')
               if status == 'unused':
                   unused_count += 1
               elif status == 'used':
                   used_count += 1
               elif status == 'revoked':
                   revoked_count += 1
   
   embed = discord.Embed(
       title="🔑 Beta Key Statistics",
       color=0x2196F3
   )
   embed.add_field(name="🆕 Unused Keys", value=str(unused_count), inline=True)
   embed.add_field(name="✅ Used Keys", value=str(used_count), inline=True)
   embed.add_field(name="❌ Revoked Keys", value=str(revoked_count), inline=True)
   embed.add_field(name="📊 Total Issued", value=str(unused_count + used_count + revoked_count), inline=True)
   
   await ctx.send(embed=embed)

@bot.command(name='list_unused')
@commands.has_permissions(administrator=True) 
async def list_unused_keys(ctx):
   """List all unused beta keys"""
   users = db.get_all_users()
   
   unused_keys = []
   for user_id, username in users:
       current_key = db.get_user_data(user_id, 'current_beta_key')
       if current_key:
           key_data = db.get_user_data(user_id, f'beta_key_{current_key}')
           if key_data:
               key_info = json.loads(key_data)
               if key_info.get('status') == 'unused':
                   created = key_info.get('created_at', 'Unknown')[:10]  # Just date
                   unused_keys.append(f"`{current_key}` - <@{user_id}> ({created})")
   
   if not unused_keys:
       await ctx.send("No unused keys found")
       return
   
   # Split into chunks if too long
   chunk_size = 10
   for i in range(0, len(unused_keys), chunk_size):
       chunk = unused_keys[i:i + chunk_size]
       embed = discord.Embed(
           title=f"🔑 Unused Beta Keys ({i+1}-{min(i+chunk_size, len(unused_keys))} of {len(unused_keys)})",
           description="\n".join(chunk),
           color=0xFFC107
       )
       await ctx.send(embed=embed)

@bot.event
async def on_command_error(ctx, error):
   if isinstance(error, commands.MissingPermissions):
       await ctx.send("❌ You don't have permission to use this command.")
   else:
       print(f"Error: {error}")

if __name__ == "__main__":
   bot.run(BOT_TOKEN)
