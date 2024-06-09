using System;
using System.Collections.Generic;

namespace NetOracleEntityFramework.Models;

public partial class Mediatype
{
    public decimal Mediatypeid { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<Track> Tracks { get; set; } = new List<Track>();
}
