title 'Project Properties'

control 'gcp-project' do

  impact 1.0
  title 'Ensure that the project was created and has the correct settings'

  describe gcp_project('silicon-vertex-398188') do
    it { should exist }
    its('name') { should eq 'My First Project' }
    its('project_number') { should eq '3934801284823' }
    its('lifecycle_state') { should eq 'ACTIVE' }
  end

end
