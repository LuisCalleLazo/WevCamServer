using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebCamServer.Migrations
{
    /// <inheritdoc />
    public partial class MissingDateGenderMissing : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Gender",
                table: "missing",
                type: "boolean",
                nullable: false,
                defaultValue: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "MissingDate",
                table: "missing",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Gender",
                table: "missing");

            migrationBuilder.DropColumn(
                name: "MissingDate",
                table: "missing");
        }
    }
}
