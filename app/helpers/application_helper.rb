module ApplicationHelper
    
    # Returns the full title on a per-page basis.
    def full_title(page_title = '')
        base_title = I18n.t 'titles.base'
        if page_title.blank?
            base_title
        else
            page_title + " | " + base_title
        end
    end
end
