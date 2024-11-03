using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace WebCamServer.Migrations
{
    /// <inheritdoc />
    public partial class ChangeSnakeCase : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Admins_Users_UserId",
                table: "Admins");

            migrationBuilder.DropForeignKey(
                name: "FK_Contacts_Seekers_SeekerId",
                table: "Contacts");

            migrationBuilder.DropForeignKey(
                name: "FK_FoundVideos_Cameras_CameraId",
                table: "FoundVideos");

            migrationBuilder.DropForeignKey(
                name: "FK_FoundVideos_Missings_MissingId",
                table: "FoundVideos");

            migrationBuilder.DropForeignKey(
                name: "FK_Missings_Seekers_SeekerId",
                table: "Missings");

            migrationBuilder.DropForeignKey(
                name: "FK_Notifications_Users_UserId",
                table: "Notifications");

            migrationBuilder.DropForeignKey(
                name: "FK_Seekers_Users_UserId",
                table: "Seekers");

            migrationBuilder.DropForeignKey(
                name: "FK_Tokens_Users_UserId",
                table: "Tokens");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_UserInfos_UserInfoId",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Contacts",
                table: "Contacts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Users",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserInfos",
                table: "UserInfos");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Tokens",
                table: "Tokens");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Seekers",
                table: "Seekers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Notifications",
                table: "Notifications");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Missings",
                table: "Missings");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FoundVideos",
                table: "FoundVideos");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Cameras",
                table: "Cameras");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Admins",
                table: "Admins");

            migrationBuilder.RenameTable(
                name: "Contacts",
                newName: "contacts");

            migrationBuilder.RenameTable(
                name: "Users",
                newName: "user");

            migrationBuilder.RenameTable(
                name: "UserInfos",
                newName: "user_info");

            migrationBuilder.RenameTable(
                name: "Tokens",
                newName: "token");

            migrationBuilder.RenameTable(
                name: "Seekers",
                newName: "seeker");

            migrationBuilder.RenameTable(
                name: "Notifications",
                newName: "notification");

            migrationBuilder.RenameTable(
                name: "Missings",
                newName: "missing");

            migrationBuilder.RenameTable(
                name: "FoundVideos",
                newName: "found_video");

            migrationBuilder.RenameTable(
                name: "Cameras",
                newName: "camera");

            migrationBuilder.RenameTable(
                name: "Admins",
                newName: "admin");

            migrationBuilder.RenameIndex(
                name: "IX_Contacts_SeekerId",
                table: "contacts",
                newName: "IX_contacts_SeekerId");

            migrationBuilder.RenameIndex(
                name: "IX_Users_UserInfoId",
                table: "user",
                newName: "IX_user_UserInfoId");

            migrationBuilder.RenameIndex(
                name: "IX_Users_Name",
                table: "user",
                newName: "IX_user_Name");

            migrationBuilder.RenameIndex(
                name: "IX_Users_Email",
                table: "user",
                newName: "IX_user_Email");

            migrationBuilder.RenameIndex(
                name: "IX_Tokens_UserId",
                table: "token",
                newName: "IX_token_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_Seekers_UserId",
                table: "seeker",
                newName: "IX_seeker_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_Notifications_UserId",
                table: "notification",
                newName: "IX_notification_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_Missings_SeekerId",
                table: "missing",
                newName: "IX_missing_SeekerId");

            migrationBuilder.RenameIndex(
                name: "IX_FoundVideos_MissingId",
                table: "found_video",
                newName: "IX_found_video_MissingId");

            migrationBuilder.RenameIndex(
                name: "IX_FoundVideos_CameraId",
                table: "found_video",
                newName: "IX_found_video_CameraId");

            migrationBuilder.RenameIndex(
                name: "IX_Admins_UserId",
                table: "admin",
                newName: "IX_admin_UserId");

            migrationBuilder.AddColumn<string>(
                name: "Ci",
                table: "user_info",
                type: "text",
                nullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "token",
                type: "integer",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text")
                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddPrimaryKey(
                name: "PK_contacts",
                table: "contacts",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_user",
                table: "user",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_user_info",
                table: "user_info",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_token",
                table: "token",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_seeker",
                table: "seeker",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_notification",
                table: "notification",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_missing",
                table: "missing",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_found_video",
                table: "found_video",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_camera",
                table: "camera",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_admin",
                table: "admin",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_admin_user_UserId",
                table: "admin",
                column: "UserId",
                principalTable: "user",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_contacts_seeker_SeekerId",
                table: "contacts",
                column: "SeekerId",
                principalTable: "seeker",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_found_video_camera_CameraId",
                table: "found_video",
                column: "CameraId",
                principalTable: "camera",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_found_video_missing_MissingId",
                table: "found_video",
                column: "MissingId",
                principalTable: "missing",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_missing_seeker_SeekerId",
                table: "missing",
                column: "SeekerId",
                principalTable: "seeker",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_notification_user_UserId",
                table: "notification",
                column: "UserId",
                principalTable: "user",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_seeker_user_UserId",
                table: "seeker",
                column: "UserId",
                principalTable: "user",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_token_user_UserId",
                table: "token",
                column: "UserId",
                principalTable: "user",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_user_user_info_UserInfoId",
                table: "user",
                column: "UserInfoId",
                principalTable: "user_info",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_admin_user_UserId",
                table: "admin");

            migrationBuilder.DropForeignKey(
                name: "FK_contacts_seeker_SeekerId",
                table: "contacts");

            migrationBuilder.DropForeignKey(
                name: "FK_found_video_camera_CameraId",
                table: "found_video");

            migrationBuilder.DropForeignKey(
                name: "FK_found_video_missing_MissingId",
                table: "found_video");

            migrationBuilder.DropForeignKey(
                name: "FK_missing_seeker_SeekerId",
                table: "missing");

            migrationBuilder.DropForeignKey(
                name: "FK_notification_user_UserId",
                table: "notification");

            migrationBuilder.DropForeignKey(
                name: "FK_seeker_user_UserId",
                table: "seeker");

            migrationBuilder.DropForeignKey(
                name: "FK_token_user_UserId",
                table: "token");

            migrationBuilder.DropForeignKey(
                name: "FK_user_user_info_UserInfoId",
                table: "user");

            migrationBuilder.DropPrimaryKey(
                name: "PK_contacts",
                table: "contacts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_user_info",
                table: "user_info");

            migrationBuilder.DropPrimaryKey(
                name: "PK_user",
                table: "user");

            migrationBuilder.DropPrimaryKey(
                name: "PK_token",
                table: "token");

            migrationBuilder.DropPrimaryKey(
                name: "PK_seeker",
                table: "seeker");

            migrationBuilder.DropPrimaryKey(
                name: "PK_notification",
                table: "notification");

            migrationBuilder.DropPrimaryKey(
                name: "PK_missing",
                table: "missing");

            migrationBuilder.DropPrimaryKey(
                name: "PK_found_video",
                table: "found_video");

            migrationBuilder.DropPrimaryKey(
                name: "PK_camera",
                table: "camera");

            migrationBuilder.DropPrimaryKey(
                name: "PK_admin",
                table: "admin");

            migrationBuilder.DropColumn(
                name: "Ci",
                table: "user_info");

            migrationBuilder.RenameTable(
                name: "contacts",
                newName: "Contacts");

            migrationBuilder.RenameTable(
                name: "user_info",
                newName: "UserInfos");

            migrationBuilder.RenameTable(
                name: "user",
                newName: "Users");

            migrationBuilder.RenameTable(
                name: "token",
                newName: "Tokens");

            migrationBuilder.RenameTable(
                name: "seeker",
                newName: "Seekers");

            migrationBuilder.RenameTable(
                name: "notification",
                newName: "Notifications");

            migrationBuilder.RenameTable(
                name: "missing",
                newName: "Missings");

            migrationBuilder.RenameTable(
                name: "found_video",
                newName: "FoundVideos");

            migrationBuilder.RenameTable(
                name: "camera",
                newName: "Cameras");

            migrationBuilder.RenameTable(
                name: "admin",
                newName: "Admins");

            migrationBuilder.RenameIndex(
                name: "IX_contacts_SeekerId",
                table: "Contacts",
                newName: "IX_Contacts_SeekerId");

            migrationBuilder.RenameIndex(
                name: "IX_user_UserInfoId",
                table: "Users",
                newName: "IX_Users_UserInfoId");

            migrationBuilder.RenameIndex(
                name: "IX_user_Name",
                table: "Users",
                newName: "IX_Users_Name");

            migrationBuilder.RenameIndex(
                name: "IX_user_Email",
                table: "Users",
                newName: "IX_Users_Email");

            migrationBuilder.RenameIndex(
                name: "IX_token_UserId",
                table: "Tokens",
                newName: "IX_Tokens_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_seeker_UserId",
                table: "Seekers",
                newName: "IX_Seekers_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_notification_UserId",
                table: "Notifications",
                newName: "IX_Notifications_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_missing_SeekerId",
                table: "Missings",
                newName: "IX_Missings_SeekerId");

            migrationBuilder.RenameIndex(
                name: "IX_found_video_MissingId",
                table: "FoundVideos",
                newName: "IX_FoundVideos_MissingId");

            migrationBuilder.RenameIndex(
                name: "IX_found_video_CameraId",
                table: "FoundVideos",
                newName: "IX_FoundVideos_CameraId");

            migrationBuilder.RenameIndex(
                name: "IX_admin_UserId",
                table: "Admins",
                newName: "IX_Admins_UserId");

            migrationBuilder.AlterColumn<string>(
                name: "Id",
                table: "Tokens",
                type: "text",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .OldAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Contacts",
                table: "Contacts",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserInfos",
                table: "UserInfos",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Users",
                table: "Users",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Tokens",
                table: "Tokens",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Seekers",
                table: "Seekers",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Notifications",
                table: "Notifications",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Missings",
                table: "Missings",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_FoundVideos",
                table: "FoundVideos",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Cameras",
                table: "Cameras",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Admins",
                table: "Admins",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Admins_Users_UserId",
                table: "Admins",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Contacts_Seekers_SeekerId",
                table: "Contacts",
                column: "SeekerId",
                principalTable: "Seekers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FoundVideos_Cameras_CameraId",
                table: "FoundVideos",
                column: "CameraId",
                principalTable: "Cameras",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FoundVideos_Missings_MissingId",
                table: "FoundVideos",
                column: "MissingId",
                principalTable: "Missings",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Missings_Seekers_SeekerId",
                table: "Missings",
                column: "SeekerId",
                principalTable: "Seekers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Notifications_Users_UserId",
                table: "Notifications",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Seekers_Users_UserId",
                table: "Seekers",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Tokens_Users_UserId",
                table: "Tokens",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Users_UserInfos_UserInfoId",
                table: "Users",
                column: "UserInfoId",
                principalTable: "UserInfos",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
