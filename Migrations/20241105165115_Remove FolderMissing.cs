using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebCamServer.Migrations
{
    /// <inheritdoc />
    public partial class RemoveFolderMissing : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DirPhotos",
                table: "missing");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DirPhotos",
                table: "missing",
                type: "text",
                nullable: true);
        }
    }
}
