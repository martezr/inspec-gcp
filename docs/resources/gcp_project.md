# gcp_project

Use the `gcp_project` InSpec audit resource to test properties of a GCP project.

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a GCP project exist

    describe gcp_project('silicon-vertex-398188') do
      it { should exist }
    end

### Test the name of a GCP project

    describe gcp_project('silicon-vertex-398188') do
      its('name') { should eq 'My First Project' }
    end

### Test the project number of a GCP project

    describe gcp_project('silicon-vertex-398188') do
      its('project_number') { should eq '3934801284823' }
    end

### Test the status of a GCP project
    describe gcp_project('silicon-vertex-398188') do
      its('lifecycle_state') { should eq 'ACTIVE' }
    end

### Test that a GCP instance has the correct labels

    describe gcp_project('silicon-vertex-398188') do
      its('labels') { should include(key: 'contact', value: 'operations') }
    end
