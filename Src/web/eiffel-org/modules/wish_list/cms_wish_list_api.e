note
	description: "[
		API to manage CMS Wish List.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_LIST_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create {CMS_WISH_LIST_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_wish_list_storage: CMS_WISH_LIST_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_wish_list_storage'.
		do
			wish_list_storage := a_wish_list_storage
			make (a_api)
		ensure
			wish_list_storage_set:  wish_list_storage = a_wish_list_storage
		end

feature {CMS_MODULE} -- Access: Wish List storage.

	wish_list_storage: CMS_WISH_LIST_STORAGE_I
			-- storage interface.


feature -- Access Wish List

	row_count_wish_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- Row count for wish list
		do
			Result := wish_list_storage.row_count_wish_list (a_category, a_status, a_filter, a_content)
		end


	wish_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_WISH_LIST]
			-- All Wishlist items, filter by page `a_page_numer' and rows per page `a_row_per_page'
		do
			Result := wish_list_storage.wish_list (a_page_number, a_rows_per_page, a_category, a_status, a_column, a_order, a_filter, a_content)
		end

	wish_by_id (a_wid: INTEGER): detachable CMS_WISH_LIST
			-- Wish list item for the given id `a_wid', if any.
		require
			valid_id: a_wid > 0
		do
			Result := wish_list_storage.wish_by_id (a_wid)
			if Result /= Void then
				if attached wish_list_storage.wish_interactions (a_wid) as l_interactions then
					Result.set_interactions (l_interactions)
					across l_interactions as c loop
						c.item.set_attachments (wish_list_storage.wish_attachments (a_wid, c.item.id))
					end
				end
				if attached wish_list_storage.wish_attachments (a_wid, 0) as l_attachments then
					Result.set_attachments (l_attachments)
				end
			end
		end

	wish_attachments (a_wid: INTEGER_64): LIST [CMS_WISH_FILE]
			--  Wish list attachments for a given wish `a_wid', if any.
		do
			if attached wish_list_storage.wish_attachments (a_wid, 0) as l_list then
				Result := l_list
			else
				create {ARRAYED_LIST [CMS_WISH_FILE]} Result.make (0)
			end
		end

	wish_interactions_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): LIST [CMS_WISH_FILE]
			--  Wish list attachments for a given wish `a_wid', if any.
		do
			if attached wish_list_storage.wish_attachments (a_wid, a_interaction_id) as l_list then
				Result := l_list
			else
				create {ARRAYED_LIST [CMS_WISH_FILE]} Result.make (0)
			end
		end

feature -- Change wish list

	save_wish (a_wish: CMS_WISH_LIST)
			-- Save a new wish `a_wish'.
		do
			wish_list_storage.save_wish (a_wish)
		end

	save_wish_interaction (a_wish_interaction: CMS_WISH_LIST_INTERACTION)
			-- Save a new wish `a_wish_interaction' interaction.
		do
			wish_list_storage.save_wish_interaction (a_wish_interaction)
		end

	upload_wish_attachment (a_id: INTEGER_64; a_file: CMS_WISH_FILE)
			-- Save attachement `a_file' for the wish list item associated with the id `a_id'.
		do
			wish_list_storage.upload_wish_attachment  (a_id, 0,  a_file.size, a_file.content, a_file.name)
		end

	upload_wish_interaction_attachment (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_file: CMS_WISH_FILE)
			-- Save attachement `a_file' for the wish list item associated with the id `a_id'.
		do
			wish_list_storage.upload_wish_attachment  (a_id, a_interaction_id,  a_file.size, a_file.content, a_file.name)
		end

	remove_wish_attachments (a_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		do
			wish_list_storage.remove_wish_attachments (a_id, 0)
		end

	remove_wish_interaction_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		do
			wish_list_storage.remove_wish_attachments (a_id, a_interaction_id)
		end

	remove_wish_attachment_by_name (a_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- Remove attachment with name `a_name' associated with wish `a_id'.
		do
			wish_list_storage.remove_wish_attachment_by_name (a_id, 0, a_name)
		end

	remove_wish_interaction_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- Remove attachment with name `a_name' associated with wish `a_id'.
		do
			wish_list_storage.remove_wish_attachment_by_name (a_id, a_interaction_id, a_name)
		end

feature -- Access - Categories

	categories: LIST [CMS_WISH_LIST_CATEGORY]
			-- List of wish list categories.
		do
			Result := wish_list_storage.categories
		end

feature -- Access - Status

	status: LIST [CMS_WISH_LIST_STATUS]
			-- List of wish list status.
		do
			Result := wish_list_storage.status
		end

end
