using Spectre.Console;

namespace NetConsolePostgresfEf
{
    internal static class Program
    {
        /*
        dotnet ef dbcontext scaffold "Host=localhost;Username=postgres;Password=DEMO123*;Database=chinook;" Npgsql.EntityFrameworkCore.PostgreSQL --output-dir "Models"
        */

        public const string ConnectionString = $"Host=localhost;Username=postgres;Password=DEMO123*;Database=chinook;";

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
