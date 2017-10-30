require 'json'

class GcpInstance < Inspec.resource(1)
  name 'gcp_instance'
  desc 'Verifies settings for an instance'

  example "
    describe gcp_instance(name: 'my-instance') do
      it { should be_running }
      it { should have_roles }
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
      return @error['error']['message']
    end
  end

  def cpu_platform
    if @instance
      @instance.cpu_platform
    else
      return @error['error']['message']
    end
  end

  def name
    if @instance
      @instance.name
    else
      return @error['error']['message']
    end
  end

  def machine_type
    if @instance
      @instance.machine_type.split('/').last
    else
      return @error['error']['message']
    end
  end

  def status
    if @instance
      @instance.status.downcase
    else
      return @error['error']['message']
    end
  end

  def has_network_tag?(tag_name)
    test = false

    tags = @instance.tags.items
    tags.each do |tag|
      if tag == tag_name
        puts tag_name
        test = true
        break
      end
    end

  test
  end

  def exists?
    !@instance.nil?
  end

  def to_s
    "GCP Instance #{@display_name}"
  end

end
