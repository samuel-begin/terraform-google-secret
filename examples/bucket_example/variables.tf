/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "application_list" {
  description = "The list of application names that will store secrets"
  type        = "list"
  default     = []
}

variable "env_list" {
  description = "The list of environments for secrets"
  type        = "list"
  default     = []
}

variable "project_name" {
  description = "The name of the project this applies to"
}

variable "credentials_file_path" {
  description = "GCP credentials fils"
}
