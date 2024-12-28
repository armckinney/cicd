variable "directory" {
  type        = string
  description = "Parent directory for the file."
  nullable    = false
}

variable "file_name" {
  type        = string
  description = "Name of file."
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
