﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebCamServer.Migrations
{
    /// <inheritdoc />
    public partial class RemoveNameGmailUserInfo : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Email",
                table: "user_info");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "user_info");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "user_info",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "user_info",
                type: "text",
                nullable: true);
        }
    }
}
