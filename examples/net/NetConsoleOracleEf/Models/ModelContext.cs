using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace NetConsoleOracleEf.Models;

public partial class ModelContext : DbContext
{
    public ModelContext()
    {
    }

    public ModelContext(DbContextOptions<ModelContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Album> Albums { get; set; }

    public virtual DbSet<Artist> Artists { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Invoice> Invoices { get; set; }

    public virtual DbSet<Invoiceline> Invoicelines { get; set; }

    public virtual DbSet<Mediatype> Mediatypes { get; set; }

    public virtual DbSet<Playlist> Playlists { get; set; }

    public virtual DbSet<Track> Tracks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseOracle("User Id=chinook;Password=chinook;Data Source=localhost/ORCLPDB;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .HasDefaultSchema("CHINOOK")
            .UseCollation("USING_NLS_COMP");

        modelBuilder.Entity<Album>(entity =>
        {
            entity.ToTable("ALBUM");

            entity.Property(e => e.Albumid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("ALBUMID");
            entity.Property(e => e.Artistid)
                .HasColumnType("NUMBER")
                .HasColumnName("ARTISTID");
            entity.Property(e => e.Title)
                .HasMaxLength(160)
                .IsUnicode(false)
                .HasColumnName("TITLE");

            entity.HasOne(d => d.Artist).WithMany(p => p.Albums)
                .HasForeignKey(d => d.Artistid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ALBUMARTISTID");
        });

        modelBuilder.Entity<Artist>(entity =>
        {
            entity.ToTable("ARTIST");

            entity.Property(e => e.Artistid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("ARTISTID");
            entity.Property(e => e.Name)
                .HasMaxLength(120)
                .IsUnicode(false)
                .HasColumnName("NAME");
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.ToTable("CUSTOMER");

            entity.Property(e => e.Customerid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("CUSTOMERID");
            entity.Property(e => e.Address)
                .HasMaxLength(80)
                .IsUnicode(false)
                .HasColumnName("ADDRESS");
            entity.Property(e => e.City)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("CITY");
            entity.Property(e => e.Company)
                .HasMaxLength(80)
                .IsUnicode(false)
                .HasColumnName("COMPANY");
            entity.Property(e => e.Country)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("COUNTRY");
            entity.Property(e => e.Email)
                .HasMaxLength(60)
                .IsUnicode(false)
                .HasColumnName("EMAIL");
            entity.Property(e => e.Fax)
                .HasMaxLength(24)
                .IsUnicode(false)
                .HasColumnName("FAX");
            entity.Property(e => e.Firstname)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("FIRSTNAME");
            entity.Property(e => e.Lastname)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("LASTNAME");
            entity.Property(e => e.Phone)
                .HasMaxLength(24)
                .IsUnicode(false)
                .HasColumnName("PHONE");
            entity.Property(e => e.Postalcode)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("POSTALCODE");
            entity.Property(e => e.State)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("STATE");
            entity.Property(e => e.Supportrepid)
                .HasColumnType("NUMBER")
                .HasColumnName("SUPPORTREPID");

            entity.HasOne(d => d.Supportrep).WithMany(p => p.Customers)
                .HasForeignKey(d => d.Supportrepid)
                .HasConstraintName("FK_CUSTOMERSUPPORTREPID");
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.ToTable("EMPLOYEE");

            entity.Property(e => e.Employeeid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("EMPLOYEEID");
            entity.Property(e => e.Address)
                .HasMaxLength(70)
                .IsUnicode(false)
                .HasColumnName("ADDRESS");
            entity.Property(e => e.Birthdate)
                .HasColumnType("DATE")
                .HasColumnName("BIRTHDATE");
            entity.Property(e => e.City)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("CITY");
            entity.Property(e => e.Country)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("COUNTRY");
            entity.Property(e => e.Email)
                .HasMaxLength(60)
                .IsUnicode(false)
                .HasColumnName("EMAIL");
            entity.Property(e => e.Fax)
                .HasMaxLength(24)
                .IsUnicode(false)
                .HasColumnName("FAX");
            entity.Property(e => e.Firstname)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("FIRSTNAME");
            entity.Property(e => e.Hiredate)
                .HasColumnType("DATE")
                .HasColumnName("HIREDATE");
            entity.Property(e => e.Lastname)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("LASTNAME");
            entity.Property(e => e.Phone)
                .HasMaxLength(24)
                .IsUnicode(false)
                .HasColumnName("PHONE");
            entity.Property(e => e.Postalcode)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("POSTALCODE");
            entity.Property(e => e.Reportsto)
                .HasColumnType("NUMBER")
                .HasColumnName("REPORTSTO");
            entity.Property(e => e.State)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("STATE");
            entity.Property(e => e.Title)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("TITLE");

            entity.HasOne(d => d.ReportstoNavigation).WithMany(p => p.InverseReportstoNavigation)
                .HasForeignKey(d => d.Reportsto)
                .HasConstraintName("FK_EMPLOYEEREPORTSTO");
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.ToTable("GENRE");

            entity.Property(e => e.Genreid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("GENREID");
            entity.Property(e => e.Name)
                .HasMaxLength(120)
                .IsUnicode(false)
                .HasColumnName("NAME");
        });

        modelBuilder.Entity<Invoice>(entity =>
        {
            entity.ToTable("INVOICE");

            entity.Property(e => e.Invoiceid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("INVOICEID");
            entity.Property(e => e.Billingaddress)
                .HasMaxLength(70)
                .IsUnicode(false)
                .HasColumnName("BILLINGADDRESS");
            entity.Property(e => e.Billingcity)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("BILLINGCITY");
            entity.Property(e => e.Billingcountry)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("BILLINGCOUNTRY");
            entity.Property(e => e.Billingpostalcode)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("BILLINGPOSTALCODE");
            entity.Property(e => e.Billingstate)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("BILLINGSTATE");
            entity.Property(e => e.Customerid)
                .HasColumnType("NUMBER")
                .HasColumnName("CUSTOMERID");
            entity.Property(e => e.Invoicedate)
                .HasColumnType("DATE")
                .HasColumnName("INVOICEDATE");
            entity.Property(e => e.Total)
                .HasColumnType("NUMBER(10,2)")
                .HasColumnName("TOTAL");

            entity.HasOne(d => d.Customer).WithMany(p => p.Invoices)
                .HasForeignKey(d => d.Customerid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_INVOICECUSTOMERID");
        });

        modelBuilder.Entity<Invoiceline>(entity =>
        {
            entity.ToTable("INVOICELINE");

            entity.Property(e => e.Invoicelineid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("INVOICELINEID");
            entity.Property(e => e.Invoiceid)
                .HasColumnType("NUMBER")
                .HasColumnName("INVOICEID");
            entity.Property(e => e.Quantity)
                .HasColumnType("NUMBER")
                .HasColumnName("QUANTITY");
            entity.Property(e => e.Trackid)
                .HasColumnType("NUMBER")
                .HasColumnName("TRACKID");
            entity.Property(e => e.Unitprice)
                .HasColumnType("NUMBER(10,2)")
                .HasColumnName("UNITPRICE");

            entity.HasOne(d => d.Invoice).WithMany(p => p.Invoicelines)
                .HasForeignKey(d => d.Invoiceid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_INVOICELINEINVOICEID");

            entity.HasOne(d => d.Track).WithMany(p => p.Invoicelines)
                .HasForeignKey(d => d.Trackid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_INVOICELINETRACKID");
        });

        modelBuilder.Entity<Mediatype>(entity =>
        {
            entity.ToTable("MEDIATYPE");

            entity.Property(e => e.Mediatypeid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("MEDIATYPEID");
            entity.Property(e => e.Name)
                .HasMaxLength(120)
                .IsUnicode(false)
                .HasColumnName("NAME");
        });

        modelBuilder.Entity<Playlist>(entity =>
        {
            entity.ToTable("PLAYLIST");

            entity.Property(e => e.Playlistid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("PLAYLISTID");
            entity.Property(e => e.Name)
                .HasMaxLength(120)
                .IsUnicode(false)
                .HasColumnName("NAME");

            entity.HasMany(d => d.Tracks).WithMany(p => p.Playlists)
                .UsingEntity<Dictionary<string, object>>(
                    "Playlisttrack",
                    r => r.HasOne<Track>().WithMany()
                        .HasForeignKey("Trackid")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_PLAYLISTTRACKTRACKID"),
                    l => l.HasOne<Playlist>().WithMany()
                        .HasForeignKey("Playlistid")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_PLAYLISTTRACKPLAYLISTID"),
                    j =>
                    {
                        j.HasKey("Playlistid", "Trackid");
                        j.ToTable("PLAYLISTTRACK");
                        j.IndexerProperty<decimal>("Playlistid")
                            .HasColumnType("NUMBER")
                            .HasColumnName("PLAYLISTID");
                        j.IndexerProperty<decimal>("Trackid")
                            .HasColumnType("NUMBER")
                            .HasColumnName("TRACKID");
                    });
        });

        modelBuilder.Entity<Track>(entity =>
        {
            entity.ToTable("TRACK");

            entity.Property(e => e.Trackid)
                .ValueGeneratedOnAdd()
                .HasColumnType("NUMBER")
                .HasColumnName("TRACKID");
            entity.Property(e => e.Albumid)
                .HasColumnType("NUMBER")
                .HasColumnName("ALBUMID");
            entity.Property(e => e.Bytes)
                .HasColumnType("NUMBER")
                .HasColumnName("BYTES");
            entity.Property(e => e.Composer)
                .HasMaxLength(220)
                .IsUnicode(false)
                .HasColumnName("COMPOSER");
            entity.Property(e => e.Genreid)
                .HasColumnType("NUMBER")
                .HasColumnName("GENREID");
            entity.Property(e => e.Mediatypeid)
                .HasColumnType("NUMBER")
                .HasColumnName("MEDIATYPEID");
            entity.Property(e => e.Milliseconds)
                .HasColumnType("NUMBER")
                .HasColumnName("MILLISECONDS");
            entity.Property(e => e.Name)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("NAME");
            entity.Property(e => e.Unitprice)
                .HasColumnType("NUMBER(10,2)")
                .HasColumnName("UNITPRICE");

            entity.HasOne(d => d.Album).WithMany(p => p.Tracks)
                .HasForeignKey(d => d.Albumid)
                .HasConstraintName("FK_TRACKALBUMID");

            entity.HasOne(d => d.Genre).WithMany(p => p.Tracks)
                .HasForeignKey(d => d.Genreid)
                .HasConstraintName("FK_TRACKGENREID");

            entity.HasOne(d => d.Mediatype).WithMany(p => p.Tracks)
                .HasForeignKey(d => d.Mediatypeid)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TRACKMEDIATYPEID");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
