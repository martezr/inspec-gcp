require 'json'

class GcpImage < Inspec.resource(1)
  name 'gcp_image'
  desc 'Verifies settings for an image'

  example "
    describe gcp_image(project: 'silicon-vertex-398188',name: 'image-1') do
      it { should exist }
      its('name') { should eq 'inspec-test' }
      its('source_type') { should eq 'f1-micro' }
      its('family') { should eq 'Intel Haswell' }
      its('status') { should eq 'running' }
    end
  "

  def initialize(opts, conn = GCPConnection.new)
    @opts = opts
    @display_name = @opts[:name]
    @image_client = conn.compute_client
    begin
      @image = @image_client.get_image(@opts[:project], @opts[:name])
    rescue => e
      @image = JSON.parse(e.body)
    end
  end

  def image_id
    if @image
      @image.id.to_s
    else
      return @error['error']['message']
    end
  end

  def family
    if @image
      return @image.family
    else
      return @error['error']['message']
    end
  end

  def name
    if @image
      @image.name
    else
      return @error['error']['message']
    end
  end

  def source_image_id
    if @image
      @image.source_image_id
    else
      return @error['error']['message']
    end
  end

  def source_type
    if @image
      @image.source_type
    else
      return @error['error']['message']
    end
  end

  def status
    if @image
      @image.status.downcase
    else
      return @error['error']['message']
    end
  end

  def exists?
    !@image.nil?
  end

  def to_s
    "Image #{@display_name}"
  end

end