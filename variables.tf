variable "principal" {
  type = string
}

variable "allowed_usernames" {
  type = list(string)
}

variable "enforce_mfa" {
  type = bool
  default = true
}

variable "role_name" {
  type = string
}

variable "max_session_duration" {
  type = number
  default = 3600
}

variable "assumed_role_policy_arn" {
  type = string
}
