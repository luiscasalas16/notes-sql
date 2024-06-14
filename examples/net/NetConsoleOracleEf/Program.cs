using Spectre.Console;

namespace NetConsoleOracleEf
{
    internal static class Program
    {
        //Scaffold-DbContext "User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;" Oracle.EntityFrameworkCore -OutputDir Models

        const string connectionString = @"User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;";

        static void Main()
        {
            try
            {
                using var db = new ModelContext(connectionString);

                AnsiConsole.MarkupLine($"[white]AC/DC Albums:[/]");

                var albums = db.Albums.Where(a => a.Artist.Name == "AC/DC").Select(a => a.Title).ToList();

                foreach (var album in albums)
                    AnsiConsole.MarkupLine($"[white] - {album.EscapeMarkup()}[/]");

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
