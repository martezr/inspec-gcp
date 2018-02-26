resource "google_storage_bucket" "inspec-storage-bucket" {
  name     = "inspec-storage-bucket"
  location = "US"
}
