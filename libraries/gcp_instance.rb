require 'json'

class GcpInstance < Inspec.resource(1)
  name 'gcp_instance'
  desc 'Verifies settings for an instance'

  example "
    describe gcp_instance(project: 'silicon-vertex-398188', zone: 'us-east1-b', name: 'inspec-test') do
      it { should exist }
      its('name') { should eq 'inspec-test' }
      its('machine_type') { should eq 'f1-micro' }
      its('cpu_platform') { should eq 'Intel Haswell' }
      its('status') { should eq 'running' }
      it { should have_network_tag('test') }
    end
  "

  def initialize(opts, conn = GCPConnection.new)
    @opts = opts
    @display_name = @opts[:name]
    @instance_client = conn.compute_client
    begin
      @instance = @instance_client.get_instance(@opts[:project], @opts[:zone], @opts[:name])
    rescue => e
      @error = JSON.parse(e.body)
    end
  end

  def instance_id
    if @instance
      @instance.id.to_s
    else
      @error['error']['message']
    end
  end

  def cpu_platform
    if @instance
      @instance.cpu_platform
    else
      @error['error']['message']
    end
  end

  def name
    if @instance
      @instance.name
    else
      @error['error']['message']
    end
  end

  def machine_type
    if @instance
      @instance.machine_type.split('/').last
    else
      @error['error']['message']
    end
  end

  def status
    if @instance
      @instance.status.downcase
    else
      @error['error']['message']
    end
  end

  def has_network_tag?(tag_name)
    if @instance
      tags = @instance.tags.items
      tags.each do |tag|
        if tag == tag_name
          return true
        end
      end
    else
      @error['error']['message']
      false
    end

    false
  end

  def exists?
    !@instance.nil?
  end

  def to_s
    "Instance #{@display_name}"
  end
end
