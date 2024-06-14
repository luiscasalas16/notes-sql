using Oracle.ManagedDataAccess.Client;
using Spectre.Console;

namespace NetConsoleOracleAdo
{
    internal static class Program
    {
        const string connectionString = @"User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;";

        static async Task Main()
        {
            try
            {
                using OracleConnection connection = new(connectionString);
                using OracleCommand command = connection.CreateCommand();

                await connection.OpenAsync();

                command.CommandText =
                    @"
                    SELECT TITLE
                    FROM ALBUM
                    WHERE ARTISTID = (SELECT ARTISTID FROM ARTIST WHERE NAME = 'AC/DC')
                    ";

                AnsiConsole.MarkupLine($"[white]AC/DC Albums:[/]");

                using OracleDataReader reader = await command.ExecuteReaderAsync();

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
