using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using NetOracleEntityFramework.Models;

namespace NetOracleEntityFramework
{
    internal class ChinookDbContext : DbContext
    {
        public DbSet<Album> Album { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder
                .UseOracle(@"User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;")
                // use uppercase naming convention for tables and columns (requires EFCore.NamingConventions)
                .UseUpperCaseNamingConvention()
                // allow logging SQL queries on debug output (requires Microsoft.Extensions.Logging.Debug)
                .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddDebug()));
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //add user/schema to all models
            modelBuilder.HasDefaultSchema("CHINOOK");
        }
    }
}
