using Spectre.Console;

namespace NetOracleEntityFramework
{
    internal static class Program
    {
        static void Main()
        {
            //Scaffold-DbContext "User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;" Oracle.EntityFrameworkCore -OutputDir Models

            try
            {
                using var db = new ChinookDbContext();

                AnsiConsole.MarkupLine($"[white]AC/DC Albums:[/]");

                var albums = db
                    .Album.Where(a => a.Artist.Name == "AC/DC")
                    .Select(a => a.Title)
                    .ToList();

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
