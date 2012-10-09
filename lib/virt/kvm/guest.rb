module Virt::KVM
  class Guest < Virt::Guest

    def initialize options = {}
      super(options)
      volume_options = options.reject{|k| k == :template_path}
      if (vol_tp = volume_options[:volume_template_path])
        volume_options[:template_path] = vol_tp
      end

      @volume        = Volume.new volume_options
      @interface   ||= Interface.new options
    end

    def arch= value
      @arch = value == "i386" ? "i686" : value
    end


    protected

    def default_template_path
      "#{base_template_path}/kvm/guest.xml.erb"
    end

  end
end
