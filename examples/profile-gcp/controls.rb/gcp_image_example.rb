control 'gcp_image_example' do
  title 'Check if the Example Image matches expectations'
  impact 1.0

  describe gcp_image(project: 'silicon-vertex-398188',name: 'image-1') do
    it { should exist }
    its('name') { should eq 'inspec-test' }
    its('source_type') { should eq 'RAW' }
    its('family') { should eq 'inspec-test-family' }
    its('status') { should eq 'ready' }
  end
end
