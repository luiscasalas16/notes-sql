using System;
using System.Collections.Generic;

namespace NetConsoleOracleEf.Models;

public partial class Playlist
{
    public decimal Playlistid { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<Track> Tracks { get; set; } = new List<Track>();
}
