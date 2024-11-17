using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebCamServer.Migrations
{
    /// <inheritdoc />
    public partial class AddNameModelMissing : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "NameModel",
                table: "missing",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NameModel",
                table: "missing");
        }
    }
}
