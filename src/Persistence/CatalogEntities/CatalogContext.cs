using Microsoft.EntityFrameworkCore;
using Persistence.Context;

namespace Persistence.CatalogEntities
{
    public partial class CatalogContext : BaseContext
    {
        public CatalogContext()
        {
        }

        public CatalogContext(DbContextOptions<CatalogContextFactory> options)
            : base(options)
        {
        }

        public virtual DbSet<CompanyLicence> CompanyLicence { get; set; }
        public virtual DbSet<DbcomptaConfig> DbcomptaConfig { get; set; }
        public virtual DbSet<FlywaySchemaHistory> FlywaySchemaHistory { get; set; }
        public virtual DbSet<MasterCompany> MasterCompany { get; set; }
        public virtual DbSet<MasterDbSettings> MasterDbSettings { get; set; }
        public virtual DbSet<MasterModule> MasterModule { get; set; }
        public virtual DbSet<MasterPermission> MasterPermission { get; set; }
        public virtual DbSet<MasterRole> MasterRole { get; set; }
        public virtual DbSet<MasterRolePermission> MasterRolePermission { get; set; }
        public virtual DbSet<MasterRoleUser> MasterRoleUser { get; set; }
        public virtual DbSet<MasterSubModule> MasterSubModule { get; set; }
        public virtual DbSet<MasterUser> MasterUser { get; set; }
        public virtual DbSet<MasterUserCompany> MasterUserCompany { get; set; }
        public virtual DbSet<OauthClientDetails> OauthClientDetails { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=Catalog;User ID=dev;Password=Spark-It2016");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.0-rtm-35687");

            modelBuilder.Entity<CompanyLicence>(entity =>
            {
                entity.ToTable("CompanyLicence", "Master");

                entity.Property(e => e.DeletedToken)
                    .HasColumnName("Deleted_Token")
                    .HasMaxLength(250);

                entity.Property(e => e.ExpirationDate).HasColumnType("date");

                entity.Property(e => e.IntialDate)
                    .HasColumnType("date")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.NombreB2buser).HasColumnName("NombreB2BUser");

                entity.Property(e => e.NombreErpuser).HasColumnName("NombreERPUser");

                entity.HasOne(d => d.IdMasterCompanyNavigation)
                    .WithMany(p => p.CompanyLicence)
                    .HasForeignKey(d => d.IdMasterCompany)
                    .HasConstraintName("FK_CompanyLicence_MasterCompany");
            });

            modelBuilder.Entity<DbcomptaConfig>(entity =>
            {
                entity.ToTable("DBComptaConfig");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CompanyCode)
                    .IsRequired()
                    .HasColumnName("companyCode")
                    .HasMaxLength(255);

                entity.Property(e => e.DriverClassName)
                    .IsRequired()
                    .HasColumnName("driverClassName")
                    .HasMaxLength(255);

                entity.Property(e => e.Env)
                    .HasColumnName("env")
                    .HasMaxLength(255);

                entity.Property(e => e.Module)
                    .HasColumnName("module")
                    .HasMaxLength(255);

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasColumnName("password")
                    .HasMaxLength(255);

                entity.Property(e => e.Url)
                    .IsRequired()
                    .HasColumnName("url")
                    .HasMaxLength(255);

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasColumnName("username")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<FlywaySchemaHistory>(entity =>
            {
                entity.HasKey(e => e.InstalledRank)
                    .HasName("flyway_schema_history_pk");

                entity.ToTable("flyway_schema_history");

                entity.HasIndex(e => e.Success)
                    .HasName("flyway_schema_history_s_idx");

                entity.Property(e => e.InstalledRank)
                    .HasColumnName("installed_rank")
                    .ValueGeneratedNever();

                entity.Property(e => e.Checksum).HasColumnName("checksum");

                entity.Property(e => e.Description)
                    .HasColumnName("description")
                    .HasMaxLength(200);

                entity.Property(e => e.ExecutionTime).HasColumnName("execution_time");

                entity.Property(e => e.InstalledBy)
                    .IsRequired()
                    .HasColumnName("installed_by")
                    .HasMaxLength(100);

                entity.Property(e => e.InstalledOn)
                    .HasColumnName("installed_on")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Script)
                    .IsRequired()
                    .HasColumnName("script")
                    .HasMaxLength(1000);

                entity.Property(e => e.Success).HasColumnName("success");

                entity.Property(e => e.Type)
                    .IsRequired()
                    .HasColumnName("type")
                    .HasMaxLength(20);

                entity.Property(e => e.Version)
                    .HasColumnName("version")
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<MasterCompany>(entity =>
            {
                entity.ToTable("MasterCompany", "Master");

                entity.Property(e => e.Code).HasMaxLength(50);

                entity.Property(e => e.DataBaseName).IsRequired();

                entity.Property(e => e.DefaultLanguage).HasMaxLength(50);

                entity.Property(e => e.DeletedToken)
                    .HasColumnName("Deleted_Token")
                    .HasMaxLength(255);

                entity.Property(e => e.Email).HasMaxLength(255);

                entity.Property(e => e.GarageDataBaseName).HasMaxLength(255);

                entity.Property(e => e.Name).HasMaxLength(255);

                entity.HasOne(d => d.IdMasterDbSettingsNavigation)
                    .WithMany(p => p.MasterCompany)
                    .HasForeignKey(d => d.IdMasterDbSettings)
                    .HasConstraintName("FK_Company_DbSettings");
            });

            modelBuilder.Entity<MasterDbSettings>(entity =>
            {
                entity.ToTable("MasterDbSettings", "Master");

                entity.Property(e => e.Server).IsRequired();

                entity.Property(e => e.UserId).IsRequired();

                entity.Property(e => e.UserPassword).IsRequired();
            });

            modelBuilder.Entity<MasterModule>(entity =>
            {
                entity.ToTable("MasterModule", "Master");

                entity.HasIndex(e => e.Code)
                    .HasName("PK_MasterModule")
                    .IsUnique();

                entity.Property(e => e.Code)
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<MasterPermission>(entity =>
            {
                entity.ToTable("MasterPermission", "Master");

                entity.HasIndex(e => e.Code)
                    .HasName("PK_MasterPermission")
                    .IsUnique();

                entity.Property(e => e.Code)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdSubModuleNavigation)
                    .WithMany(p => p.MasterPermission)
                    .HasForeignKey(d => d.IdSubModule)
                    .HasConstraintName("FK_MasterPermission_MasterSubModule");
            });

            modelBuilder.Entity<MasterRole>(entity =>
            {
                entity.ToTable("MasterRole", "Master");

                entity.Property(e => e.Code)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Label)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdCompanyNavigation)
                    .WithMany(p => p.MasterRole)
                    .HasForeignKey(d => d.IdCompany)
                    .HasConstraintName("FK_MasterRole_MasterCompany");
            });

            modelBuilder.Entity<MasterRolePermission>(entity =>
            {
                entity.ToTable("MasterRolePermission", "Master");

                entity.HasOne(d => d.IdPermissionNavigation)
                    .WithMany(p => p.MasterRolePermission)
                    .HasForeignKey(d => d.IdPermission)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MasterRolePermission_MasterPermission");

                entity.HasOne(d => d.IdRoleNavigation)
                    .WithMany(p => p.MasterRolePermission)
                    .HasForeignKey(d => d.IdRole)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MasterPermission_MasterRole");
            });

            modelBuilder.Entity<MasterRoleUser>(entity =>
            {
                entity.ToTable("MasterRoleUser", "Master");

                entity.HasOne(d => d.IdMasterCompanyNavigation)
                    .WithMany(p => p.MasterRoleUser)
                    .HasForeignKey(d => d.IdMasterCompany)
                    .HasConstraintName("FK_MasterRoleUser_MasterCompany");

                entity.HasOne(d => d.IdMasterUserNavigation)
                    .WithMany(p => p.MasterRoleUser)
                    .HasForeignKey(d => d.IdMasterUser)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MasterRoleUser_MasterUser");

                entity.HasOne(d => d.IdRoleNavigation)
                    .WithMany(p => p.MasterRoleUser)
                    .HasForeignKey(d => d.IdRole)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MasterRoleUser_MasterRole");
            });

            modelBuilder.Entity<MasterSubModule>(entity =>
            {
                entity.ToTable("MasterSubModule", "Master");

                entity.HasIndex(e => e.Code)
                    .HasName("PK_MasterSubModule")
                    .IsUnique();

                entity.Property(e => e.Code)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdModuleNavigation)
                    .WithMany(p => p.MasterSubModule)
                    .HasForeignKey(d => d.IdModule)
                    .HasConstraintName("FK_MasterSubModule_MasterModule");
            });

            modelBuilder.Entity<MasterUser>(entity =>
            {
                entity.ToTable("MasterUser", "Master");

                entity.Property(e => e.AccountNonExpired)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.AccountNonLocked)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.CredentialsNonExpired)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.DeletedToken)
                    .HasColumnName("Deleted_Token")
                    .HasMaxLength(255);

                entity.Property(e => e.Email).HasMaxLength(255);

                entity.Property(e => e.Enabled)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.FirstName).HasMaxLength(255);

                entity.Property(e => e.IsBtoB).HasColumnName("IsBToB");

                entity.Property(e => e.Language).HasMaxLength(50);

                entity.Property(e => e.LastConnectedCompany).HasMaxLength(50);

                entity.Property(e => e.LastName).HasMaxLength(255);

                entity.Property(e => e.Login).HasMaxLength(255);

                entity.Property(e => e.Password).HasMaxLength(255);
            });

            modelBuilder.Entity<MasterUserCompany>(entity =>
            {
                entity.ToTable("MasterUserCompany", "Master");

                entity.Property(e => e.DeletedToken)
                    .HasColumnName("Deleted_Token")
                    .HasMaxLength(255);

                entity.Property(e => e.IsActif)
                    .IsRequired()
                    .HasDefaultValueSql("('true')");

                entity.HasOne(d => d.IdMasterCompanyNavigation)
                    .WithMany(p => p.MasterUserCompany)
                    .HasForeignKey(d => d.IdMasterCompany)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MasterUserCompany_MasterCompany");

                entity.HasOne(d => d.IdMasterUserNavigation)
                    .WithMany(p => p.MasterUserCompany)
                    .HasForeignKey(d => d.IdMasterUser)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MasterUserCompany_MasterUser");
            });

            modelBuilder.Entity<OauthClientDetails>(entity =>
            {
                entity.HasKey(e => e.ClientId);

                entity.ToTable("oauth_client_details");

                entity.Property(e => e.ClientId)
                    .HasColumnName("client_id")
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.AccessTokenValidity).HasColumnName("access_token_validity");

                entity.Property(e => e.AdditionalInformation)
                    .HasColumnName("additional_information")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Authorities)
                    .HasColumnName("authorities")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.AuthorizedGrantTypes)
                    .HasColumnName("authorized_grant_types")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Autoapprove)
                    .HasColumnName("autoapprove")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.ClientSecret)
                    .HasColumnName("client_secret")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.RefreshTokenValidity).HasColumnName("refresh_token_validity");

                entity.Property(e => e.ResourceIds)
                    .HasColumnName("resource_ids")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Scope)
                    .HasColumnName("scope")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.WebServerRedirectUri)
                    .HasColumnName("web_server_redirect_uri")
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}