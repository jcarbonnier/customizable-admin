module ActiveRecord
  class Base

    ##
    # Search method
    #-----
    def self.search(in_parameters = {})
      return all if (in_parameters.blank?)
      conditions = []
      parameters = in_parameters.delete_if { |key, v| [].include?(key) or v.blank? or v.empty? or (v.class == Array and (v - ['']).empty?) }
      parameters.each do |k, v|
        Rails.logger.info("K:#{k}=#{v}|blank:#{v.blank?}|empty:#{v.empty?}|#{v.inspect}")
        case k
          when 'action', 'controller', '_', 'per_page', 'page', 'utf8', 'sort', 'direction', 'format', 'columns'
          when 'id'
            conditions[0] << " AND #{self.table_name}.#{k}=?"
            conditions.push(v)
          # when 'role_ids'
          #   conditions[0] << " AND roles_users.role_id in (?)"
          #   conditions.push(v)
          else
            conditions[0] << " AND #{self.table_name}.#{k} like ?"
            conditions.push("%#{v}%")
        end
      end
      where(conditions) unless (conditions.blank?)
    end

    ##
    # Object to string
    #-----
    def to_s()
      return self.name if (self.attributes.include?('name'))
      return self.title if (self.attributes.include?('title'))
      return self.id if (self.attributes.include?('id'))
      return ''
    end

  end
end