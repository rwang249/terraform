terraform {
  required_version = "~> 0.12"
  backend "gcs" {
    bucket = "blah_tf_state_bucket"
    credentials="test.json"
    prefix = "test-state"
  }
}

