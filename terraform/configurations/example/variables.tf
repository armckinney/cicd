variable "environment" {
  description = "Name of environment to deploy to."
  type        = string
}

variable "file_time" {
  type        = string
  description = "Timestamp to place in file name."
  nullable    = false
}

variable "file_type" {
  type        = string
  description = "Type of file to create."
  nullable    = false
  default     = "txt"
  validation {
    condition     = contains(["txt", "md"], var.file_type)
    error_message = "Given value for variable `file_type` not in allowable range."
  }
}

todo