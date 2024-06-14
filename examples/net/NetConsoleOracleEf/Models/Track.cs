using System;
using System.Collections.Generic;

namespace NetConsoleOracleEf.Models;

public partial class Track
{
    public decimal Trackid { get; set; }

    public string Name { get; set; } = null!;

    public decimal? Albumid { get; set; }

    public decimal Mediatypeid { get; set; }

    public decimal? Genreid { get; set; }

    public string? Composer { get; set; }

    public decimal Milliseconds { get; set; }

    public decimal? Bytes { get; set; }

    public decimal Unitprice { get; set; }

    public virtual Album? Album { get; set; }

    public virtual Genre? Genre { get; set; }

    public virtual ICollection<Invoiceline> Invoicelines { get; set; } = new List<Invoiceline>();

    public virtual Mediatype Mediatype { get; set; } = null!;

    public virtual ICollection<Playlist> Playlists { get; set; } = new List<Playlist>();
}
