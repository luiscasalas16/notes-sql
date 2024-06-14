using System;
using System.Collections.Generic;

namespace NetConsoleOracleEf.Models;

public partial class Genre
{
    public decimal Genreid { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<Track> Tracks { get; set; } = new List<Track>();
}
