using Npgsql;
using Spectre.Console;

namespace NetConsolePostgresAdo
{
    internal static class Program
    {
        const string connectionString = $"Host=localhost;Username=postgres;Password=DEMO123*;Database=chinook";

        static async Task Main()
        {
            try
            {
                using NpgsqlConnection connection = new(connectionString);
                using NpgsqlCommand command = connection.CreateCommand();

                await connection.OpenAsync();

                command.CommandText =
                    @"
                    SELECT title
                    FROM album
                    WHERE artist_id = (SELECT artist_id FROM artist WHERE name = 'AC/DC')
                    ";

                AnsiConsole.MarkupLine($"[white]AC/DC Albums:[/]");

                using NpgsqlDataReader reader = await command.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                    AnsiConsole.MarkupLine($"[white] - {reader.GetString(0).EscapeMarkup()}[/]");

                AnsiConsole.MarkupLine($"[green]Success![/]");
            }
            catch (Exception ex)
            {
                AnsiConsole.WriteException(ex);
                AnsiConsole.MarkupLine($"[red]Failure[/]");
            }
        }
    }
}
