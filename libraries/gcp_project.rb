require 'json'

class GcpProject < Inspec.resource(1)
  name 'gcp_project'
  desc 'Verifies settings for a project'

  example "
    describe gcp_project(name: 'my-instance') do
      it { should be_running }
      it { should have_roles }
    end
  "

  def initialize(opts, conn = GCPConnection.new)
    @opts = opts
    @opts.is_a?(Hash) ? @display_name = @opts[:name] : @display_name = opts
    @project_client = conn.project_client
    begin
      @project = @project_client.get_project(@opts)
    rescue => e
      @error = JSON.parse(e.body)
    end
  end
  
  def project_number
    if @project
      @project.project_number.to_s
    else
      return @error['error']['message']
    end
  end


  def create_time
    if @project
      @project.create_time
    else
      return @error['error']['message']
    end
  end

  def lifecycle_state
    if @project
      @project.lifecycle_state
    else
      return @error['error']['message']
    end
  end

  def exists?
    !@project.nil?
  end

  def name
    if @project
      @project.name
    else
      return @error['error']['message']
    end
  end

  def to_s
    "Project #{@display_name}"
  end

end
