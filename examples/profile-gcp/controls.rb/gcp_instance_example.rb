control 'azure_vm_example' do
  title 'Check if the Example Instance matches expectations'
  impact 1.0

  describe gcp_instance(project: 'silicon-vertex-398188', zone: 'us-east1-b', name: 'inspec-test') do
    it { should exist }
    its('name') { should eq 'inspec-test' }
    its('machine_type') { should eq 'f1-micro' }
    its('cpu_platform') { should eq 'Intel Haswell' }
    its('status') { should eq 'running' }
    it { should have_network_tag('test') }
  end
end
