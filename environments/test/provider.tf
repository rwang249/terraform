provider "google-beta" {
  credentials = file("test.json")
  project = "test"
}

provider "google" {
  credentials = file("test.json")
  project = "test"
}