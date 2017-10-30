title 'Instance Properties'

control 'gcp-instance' do

  impact 1.0
  title 'Ensure that the instance was created and has the correct settings'

  describe gcp_instance(project: 'silicon-vertex-398188', zone: 'us-east1-b', name: 'inspec-test') do
    it { should exist }
    its('name') { should eq 'inspec-test' }
    its('machine_type') { should eq 'f1-micro' }
    its('cpu_platform') { should eq 'Intel Haswell' }
    its('status') { should eq 'running' }
    it { should have_network_tag('test') }
  end

end
