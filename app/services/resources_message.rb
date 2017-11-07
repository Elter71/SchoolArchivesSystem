class ResourcesMessage
  def initialize(model, errors)
    @errors = errors
    @model_name = model
  end

  def message
    get_message_from_table(@errors.first)
  end

  private
  def get_message_from_table(table_message)
    message = get_resources_from_locales(table_message[0])
    message += table_message[1]
  end

  def get_resources_from_locales(resources)
    I18n.t("active_interaction.attributes.#{@model_name}.#{resources}")
  end
end
