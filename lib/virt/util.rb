require "rexml/document"
require 'erb'

module Virt
  module Util
    # return templated xml to be used by libvirt
    def xml
      ERB.new(template, nil, '-').result(binding)
    end

    def to_gb bytes
      bytes.to_i / 1073741824
    end

    private
    # template file that contain our xml template
    def template(opts={})
      begin
        File.read(template_path)
      rescue => e
        warn "failed to read template #{template_path}: #{e}"
      end
    end

    def base_template_path
      "#{File.dirname(__FILE__)}/../../templates/"
    end

    # finds a value from xml
    def document path, attribute=nil
      return nil if new?
      xml = REXML::Document.new(@xml_desc)
      attribute.nil? ? xml.elements[path].text : xml.elements[path].attributes[attribute]
    end
  end
end
