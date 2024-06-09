using Oracle.ManagedDataAccess.Client;
using Spectre.Console;

namespace NetOracleAdo
{
    internal static class Program
    {
        const string user = "chinook";
        const string pwd = "chinook";
        const string db = "localhost/ORCLPDB";

        const string conStringUser =
            "User Id=" + user + ";Password=" + pwd + ";Data Source=" + db + ";";

        static async Task Main()
        {
            try
            {
                using OracleConnection connection = new(conStringUser);
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
