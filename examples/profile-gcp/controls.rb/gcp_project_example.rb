control 'gcp_project_example' do
  title 'Check if the Example Instance matches expectations'
  impact 1.0

  describe gcp_project('silicon-vertex-398188') do
    it { should exist }
    its('name') { should eq 'My First Project' }
    its('project_number') { should eq '3934801284823' }
    its('lifecycle_state') { should eq 'ACTIVE' }
    its('labels') { should include(key: 'contact', value: 'operations') }
  end
end
