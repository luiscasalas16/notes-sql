using Spectre.Console;

namespace NetConsoleOracleEf
{
    internal static class Program
    {
        /*
        dotnet ef dbcontext scaffold "User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;" Oracle.EntityFrameworkCore --output-dir "Models" --force
        */

        public const string ConnectionString = @"User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;";

        static void Main()
        {
            try
            {
                using var db = new ModelContext();

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
