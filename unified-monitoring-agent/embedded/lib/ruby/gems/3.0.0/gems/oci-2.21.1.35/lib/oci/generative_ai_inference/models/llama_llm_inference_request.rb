# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20231130
require 'date'
require_relative 'llm_inference_request'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details for the text generation request for Llama models.
  class GenerativeAiInference::Models::LlamaLlmInferenceRequest < GenerativeAiInference::Models::LlmInferenceRequest
    # Represents the prompt to be completed. The trailing white spaces are trimmed before completion.
    # @return [String]
    attr_accessor :prompt

    # Whether to stream back partial progress. If set, tokens are sent as data-only server-sent events as they become available.
    # @return [BOOLEAN]
    attr_accessor :is_stream

    # The number of of generated texts that will be returned.
    # @return [Integer]
    attr_accessor :num_generations

    # Whether or not to return the user prompt in the response. Applies only to non-stream results.
    # @return [BOOLEAN]
    attr_accessor :is_echo

    # An integer that sets up the model to use only the top k most likely tokens in the generated output. A higher k introduces more randomness into the output making the output text sound more natural. Default value is -1 which means to consider all tokens. Setting to 0 disables this method and considers all tokens.
    #
    # If also using top p, then the model considers only the top tokens whose probabilities add up to p percent and ignores the rest of the k tokens. For example, if k is 20, but the probabilities of the top 10 add up to .75, then only the top 10 tokens are chosen.
    #
    # @return [Integer]
    attr_accessor :top_k

    # If set to a probability 0.0 < p < 1.0, it ensures that only the most likely tokens, with total probability mass of p, are considered for generation at each step.
    #
    # To eliminate tokens with low likelihood, assign p a minimum percentage for the next token's likelihood. For example, when p is set to 0.75, the model eliminates the bottom 25 percent for the next token. Set to 1 to consider all tokens and set to 0 to disable. If both k and p are enabled, p acts after k.
    #
    # @return [Float]
    attr_accessor :top_p

    # A number that sets the randomness of the generated output. A lower temperature means a less random generations.
    #
    # Use lower numbers for tasks with a correct answer such as question answering or summarizing. High temperatures can generate hallucinations or factually incorrect information. Start with temperatures lower than 1.0 and increase the temperature for more creative outputs, as you regenerate the prompts to refine the outputs.
    #
    # @return [Float]
    attr_accessor :temperature

    # To reduce repetitiveness of generated tokens, this number penalizes new tokens based on their frequency in the generated text so far. Values > 0 encourage the model to use new tokens and values < 0 encourage the model to repeat tokens. Set to 0 to disable.
    # @return [Float]
    attr_accessor :frequency_penalty

    # To reduce repetitiveness of generated tokens, this number penalizes new tokens based on whether they've appeared in the generated text so far. Values > 0 encourage the model to use new tokens and values < 0 encourage the model to repeat tokens.
    #
    # Similar to frequency penalty, a penalty is applied to previously present tokens, except that this penalty is applied equally to all tokens that have already appeared, regardless of how many times they've appeared. Set to 0 to disable.
    #
    # @return [Float]
    attr_accessor :presence_penalty

    # List of strings that stop the generation if they are generated for the response text. The returned output will not contain the stop strings.
    # @return [Array<String>]
    attr_accessor :stop

    # Includes the logarithmic probabilities for the most likely output tokens and the chosen tokens.
    #
    # For example, if the log probability is 5, the API returns a list of the 5 most likely tokens. The API returns the log probability of the sampled token, so there might be up to logprobs+1 elements in the response.
    #
    # @return [Integer]
    attr_accessor :log_probs

    # The maximum number of tokens that can be generated per output sequence. The token count of the prompt plus `maxTokens` cannot exceed the model's context length.
    # @return [Integer]
    attr_accessor :max_tokens

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'runtime_type': :'runtimeType',
        'prompt': :'prompt',
        'is_stream': :'isStream',
        'num_generations': :'numGenerations',
        'is_echo': :'isEcho',
        'top_k': :'topK',
        'top_p': :'topP',
        'temperature': :'temperature',
        'frequency_penalty': :'frequencyPenalty',
        'presence_penalty': :'presencePenalty',
        'stop': :'stop',
        'log_probs': :'logProbs',
        'max_tokens': :'maxTokens'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'runtime_type': :'String',
        'prompt': :'String',
        'is_stream': :'BOOLEAN',
        'num_generations': :'Integer',
        'is_echo': :'BOOLEAN',
        'top_k': :'Integer',
        'top_p': :'Float',
        'temperature': :'Float',
        'frequency_penalty': :'Float',
        'presence_penalty': :'Float',
        'stop': :'Array<String>',
        'log_probs': :'Integer',
        'max_tokens': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :prompt The value to assign to the {#prompt} property
    # @option attributes [BOOLEAN] :is_stream The value to assign to the {#is_stream} property
    # @option attributes [Integer] :num_generations The value to assign to the {#num_generations} property
    # @option attributes [BOOLEAN] :is_echo The value to assign to the {#is_echo} property
    # @option attributes [Integer] :top_k The value to assign to the {#top_k} property
    # @option attributes [Float] :top_p The value to assign to the {#top_p} property
    # @option attributes [Float] :temperature The value to assign to the {#temperature} property
    # @option attributes [Float] :frequency_penalty The value to assign to the {#frequency_penalty} property
    # @option attributes [Float] :presence_penalty The value to assign to the {#presence_penalty} property
    # @option attributes [Array<String>] :stop The value to assign to the {#stop} property
    # @option attributes [Integer] :log_probs The value to assign to the {#log_probs} property
    # @option attributes [Integer] :max_tokens The value to assign to the {#max_tokens} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['runtimeType'] = 'LLAMA'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.prompt = attributes[:'prompt'] if attributes[:'prompt']

      self.is_stream = attributes[:'isStream'] unless attributes[:'isStream'].nil?
      self.is_stream = false if is_stream.nil? && !attributes.key?(:'isStream') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isStream and :is_stream' if attributes.key?(:'isStream') && attributes.key?(:'is_stream')

      self.is_stream = attributes[:'is_stream'] unless attributes[:'is_stream'].nil?
      self.is_stream = false if is_stream.nil? && !attributes.key?(:'isStream') && !attributes.key?(:'is_stream') # rubocop:disable Style/StringLiterals

      self.num_generations = attributes[:'numGenerations'] if attributes[:'numGenerations']

      raise 'You cannot provide both :numGenerations and :num_generations' if attributes.key?(:'numGenerations') && attributes.key?(:'num_generations')

      self.num_generations = attributes[:'num_generations'] if attributes[:'num_generations']

      self.is_echo = attributes[:'isEcho'] unless attributes[:'isEcho'].nil?
      self.is_echo = false if is_echo.nil? && !attributes.key?(:'isEcho') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isEcho and :is_echo' if attributes.key?(:'isEcho') && attributes.key?(:'is_echo')

      self.is_echo = attributes[:'is_echo'] unless attributes[:'is_echo'].nil?
      self.is_echo = false if is_echo.nil? && !attributes.key?(:'isEcho') && !attributes.key?(:'is_echo') # rubocop:disable Style/StringLiterals

      self.top_k = attributes[:'topK'] if attributes[:'topK']

      raise 'You cannot provide both :topK and :top_k' if attributes.key?(:'topK') && attributes.key?(:'top_k')

      self.top_k = attributes[:'top_k'] if attributes[:'top_k']

      self.top_p = attributes[:'topP'] if attributes[:'topP']
      self.top_p = 1.0 if top_p.nil? && !attributes.key?(:'topP') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :topP and :top_p' if attributes.key?(:'topP') && attributes.key?(:'top_p')

      self.top_p = attributes[:'top_p'] if attributes[:'top_p']
      self.top_p = 1.0 if top_p.nil? && !attributes.key?(:'topP') && !attributes.key?(:'top_p') # rubocop:disable Style/StringLiterals

      self.temperature = attributes[:'temperature'] if attributes[:'temperature']
      self.temperature = 1.0 if temperature.nil? && !attributes.key?(:'temperature') # rubocop:disable Style/StringLiterals

      self.frequency_penalty = attributes[:'frequencyPenalty'] if attributes[:'frequencyPenalty']
      self.frequency_penalty = 0.0 if frequency_penalty.nil? && !attributes.key?(:'frequencyPenalty') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :frequencyPenalty and :frequency_penalty' if attributes.key?(:'frequencyPenalty') && attributes.key?(:'frequency_penalty')

      self.frequency_penalty = attributes[:'frequency_penalty'] if attributes[:'frequency_penalty']
      self.frequency_penalty = 0.0 if frequency_penalty.nil? && !attributes.key?(:'frequencyPenalty') && !attributes.key?(:'frequency_penalty') # rubocop:disable Style/StringLiterals

      self.presence_penalty = attributes[:'presencePenalty'] if attributes[:'presencePenalty']
      self.presence_penalty = 0.0 if presence_penalty.nil? && !attributes.key?(:'presencePenalty') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :presencePenalty and :presence_penalty' if attributes.key?(:'presencePenalty') && attributes.key?(:'presence_penalty')

      self.presence_penalty = attributes[:'presence_penalty'] if attributes[:'presence_penalty']
      self.presence_penalty = 0.0 if presence_penalty.nil? && !attributes.key?(:'presencePenalty') && !attributes.key?(:'presence_penalty') # rubocop:disable Style/StringLiterals

      self.stop = attributes[:'stop'] if attributes[:'stop']

      self.log_probs = attributes[:'logProbs'] if attributes[:'logProbs']

      raise 'You cannot provide both :logProbs and :log_probs' if attributes.key?(:'logProbs') && attributes.key?(:'log_probs')

      self.log_probs = attributes[:'log_probs'] if attributes[:'log_probs']

      self.max_tokens = attributes[:'maxTokens'] if attributes[:'maxTokens']

      raise 'You cannot provide both :maxTokens and :max_tokens' if attributes.key?(:'maxTokens') && attributes.key?(:'max_tokens')

      self.max_tokens = attributes[:'max_tokens'] if attributes[:'max_tokens']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        runtime_type == other.runtime_type &&
        prompt == other.prompt &&
        is_stream == other.is_stream &&
        num_generations == other.num_generations &&
        is_echo == other.is_echo &&
        top_k == other.top_k &&
        top_p == other.top_p &&
        temperature == other.temperature &&
        frequency_penalty == other.frequency_penalty &&
        presence_penalty == other.presence_penalty &&
        stop == other.stop &&
        log_probs == other.log_probs &&
        max_tokens == other.max_tokens
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines

    # @see the `==` method
    # @param [Object] other the other object to be compared
    def eql?(other)
      self == other
    end

    # rubocop:disable Metrics/AbcSize, Layout/EmptyLines


    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [runtime_type, prompt, is_stream, num_generations, is_echo, top_k, top_p, temperature, frequency_penalty, presence_penalty, stop, log_probs, max_tokens].hash
    end
    # rubocop:enable Metrics/AbcSize, Layout/EmptyLines

    # rubocop:disable Metrics/AbcSize, Layout/EmptyLines


    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)

      self.class.swagger_types.each_pair do |key, type|
        if type =~ /^Array<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            public_method("#{key}=").call(
              attributes[self.class.attribute_map[key]]
                .map { |v| OCI::Internal::Util.convert_to_type(Regexp.last_match(1), v) }
            )
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          public_method("#{key}=").call(
            OCI::Internal::Util.convert_to_type(type, attributes[self.class.attribute_map[key]])
          )
        end
        # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end
    # rubocop:enable Metrics/AbcSize, Layout/EmptyLines

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = public_method(attr).call
        next if value.nil? && !instance_variable_defined?("@#{attr}")

        hash[param] = _to_hash(value)
      end
      hash
    end

    private

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end
  end
end
# rubocop:enable Lint/UnneededCopDisableDirective, Metrics/LineLength
