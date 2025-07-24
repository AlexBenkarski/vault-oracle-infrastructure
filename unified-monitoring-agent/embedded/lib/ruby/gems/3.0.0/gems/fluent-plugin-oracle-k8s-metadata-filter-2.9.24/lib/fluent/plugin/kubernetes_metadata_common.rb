# frozen_string_literal: true

#
# Fluentd Kubernetes Metadata Filter Plugin - Enrich Fluentd events with
# Kubernetes metadata
#
# Copyright 2017 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module KubernetesMetadata
  module Common
    class GoneError < StandardError
      def initialize(msg = '410 Gone')
        super
      end
    end

    def parse_namespace_metadata(namespace_object)
      log.trace("parse_namespace_metadata: #{namespace_object[:metadata][:name]}")

      kubernetes_metadata = {}

      if @log_caching
        kubernetes_metadata.merge!({'namespace_id' => namespace_object[:metadata][:uid],
                                    'creation_timestamp' => namespace_object[:metadata][:creationTimestamp]})

        # all labels for logs unless skipped
        kubernetes_metadata['namespace_labels'] = syms_to_strs(namespace_object[:metadata][:labels].to_h) unless @skip_namespace_labels
        annotations = match_annotations(syms_to_strs(namespace_object[:metadata][:annotations].to_h))
        kubernetes_metadata['namespace_annotations'] = annotations unless annotations.empty?
      elsif not @namespace_label_match.empty?()
        # only labels according to @namespace_label_match
        kubernetes_metadata['namespace_labels'] = filter_metadata(syms_to_strs(namespace_object[:metadata][:labels].to_h),
                                                                               @namespace_label_match)
      end

      kubernetes_metadata
    end

    def parse_pod_metadata(pod_object)
      log.trace("parse_pod_metadata: #{pod_object[:metadata][:name]}/#{pod_object[:metadata][:namespace]}")

      kubernetes_metadata = { 'pod_ip' => pod_object[:status][:podIP],
                              'host' => pod_object[:spec][:nodeName]}

      if @log_caching
        kubernetes_metadata.merge!({'pod_name' => pod_object[:metadata][:name],
                                    'pod_id' => pod_object[:metadata][:uid],
                                    'namespace_name' => pod_object[:metadata][:namespace]})

        # all labels for logs unless skipped
        kubernetes_metadata['labels'] = syms_to_strs(pod_object[:metadata][:labels].to_h) unless @skip_pod_labels
        annotations = match_annotations(syms_to_strs(pod_object[:metadata][:annotations].to_h))
        kubernetes_metadata['annotations'] = annotations unless annotations.empty?

        unless @skip_container_metadata
          container_meta = {}
          begin
            pod_object[:status][:containerStatuses].each do |container_status|
              container_meta[container_status[:name]] = {'image' => container_status[:image],
                                                         'image_id' => container_status[:imageID],
                                                         'container_id' => container_status[:containerID]}
            end if pod_object[:status] && pod_object[:status][:containerStatuses]
          rescue StandardError=>e
            log.warn("parsing container meta information failed for: #{pod_object[:metadata][:namespace]}/#{pod_object[:metadata][:name]}: #{e}")
          end

          kubernetes_metadata['containers'] = container_meta
        end
      elsif @pod_label_match and not @pod_label_match.empty?()
        # only labels according to @pod_label_match
        kubernetes_metadata['labels'] = filter_metadata(syms_to_strs(pod_object[:metadata][:labels].to_h),
                                                                     @pod_label_match)
      end

      kubernetes_metadata
    end

    def parse_node_metadata(node_object)
      log.trace("parse_node_metadata: #{node_object[:metadata][:name]}")

      kubernetes_metadata = {}

      if @log_caching
        # all labels for logs unless skipped
        kubernetes_metadata['node_labels'] = syms_to_strs(node_object[:metadata][:labels].to_h) unless @skip_node_labels
        annotations = match_annotations(syms_to_strs(node_object[:metadata][:annotations].to_h))
        kubernetes_metadata['node_annotations'] = annotations unless annotations.empty?
      elsif @node_label_match and not @node_label_match.empty?()
        # only labels according to @node_label_match
        kubernetes_metadata['node_labels'] = filter_metadata(syms_to_strs(node_object[:metadata][:labels].to_h),
                                                             @node_label_match)
      end

      kubernetes_metadata
    end

    def filter_metadata(metadata, match_array)
      result = {}
      match_array.each do |match_key, key_replace|
        metadata.each do |key, value|
          if key == match_key
            result[key_replace == nil ? key : key_replace] = value
          end
        end
      end
      result
    end

    def match_annotations(annotations)
      result = {}
      @annotations_regexps.each do |regexp|
        annotations.each do |key, value|
          # regex already verified
          result[key] = value if ::Fluent::StringUtil.match_regexp(regexp, key.to_s)
        end
      end
      result
    end

    def syms_to_strs(hsh)
      newhsh = {}
      hsh.each_pair do |kk, vv|
        if vv.is_a?(Hash)
          vv = syms_to_strs(vv)
        end
        if kk.is_a?(Symbol)
          newhsh[kk.to_s] = vv
        else
          newhsh[kk] = vv
        end
      end
      newhsh
    end
  end
end
