using System;
using System.Collections.Generic;

namespace NetConsoleOracleEf.Models;

public partial class Artist
{
    public decimal Artistid { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<Album> Albums { get; set; } = new List<Album>();
}
