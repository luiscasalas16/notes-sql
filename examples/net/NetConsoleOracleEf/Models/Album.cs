using System;
using System.Collections.Generic;

namespace NetConsoleOracleEf.Models;

public partial class Album
{
    public decimal Albumid { get; set; }

    public string Title { get; set; } = null!;

    public decimal Artistid { get; set; }

    public virtual Artist Artist { get; set; } = null!;

    public virtual ICollection<Track> Tracks { get; set; } = new List<Track>();
}
