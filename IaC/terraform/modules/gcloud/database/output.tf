output "sql_connection_name" {
  value       = google_sql_database_instance.database_instance.connection_name
  description = "El nombre de conexión de la instancia de base de datos SQL."
}
