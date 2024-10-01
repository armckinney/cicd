resource "local_file" "this" {
  filename = "${path.cwd}/${var.directory}/${var.file_name}.${var.file_type}"
  content  = "/workspaces/terraform-workflows/tests/terraform/modules/example/file.tf"
}
