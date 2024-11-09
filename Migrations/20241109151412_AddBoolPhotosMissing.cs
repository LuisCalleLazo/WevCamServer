using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebCamServer.Migrations
{
    /// <inheritdoc />
    public partial class AddBoolPhotosMissing : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "PhotosFront",
                table: "missing",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "PhotosLeft",
                table: "missing",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "PhotosRigth",
                table: "missing",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PhotosFront",
                table: "missing");

            migrationBuilder.DropColumn(
                name: "PhotosLeft",
                table: "missing");

            migrationBuilder.DropColumn(
                name: "PhotosRigth",
                table: "missing");
        }
    }
}
