module Spree
  module Admin
    class VendorsController < ResourceController
      include Translatable

      def create
        if permitted_resource_params[:image]
          @vendor.build_image(attachment: permitted_resource_params.delete(:image))
        end
        invoke_callbacks(:create, :before)
        @object.attributes = permitted_resource_params
        if @object.save
          invoke_callbacks(:create, :after)
          flash[:success] = flash_message_for(@object, :successfully_created)
          respond_with(@object) do |format|
            format.turbo_stream if create_turbo_stream_enabled?
            format.html { redirect_to business_details_admin_vendors_url(id: @object.id) }
            format.js   { render layout: false }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@object) do |format|
            format.html { render action: :new, status: :unprocessable_entity }
            format.js { render layout: false, status: :unprocessable_entity }
          end
        end
      end

      def update
        if permitted_resource_params[:image]
          @vendor.create_image(attachment: permitted_resource_params.delete(:image))
        end
        invoke_callbacks(:update, :before)
        if @object.update(permitted_resource_params)
          set_current_store
          invoke_callbacks(:update, :after)
          respond_with(@object) do |format|
            format.turbo_stream if update_turbo_stream_enabled?
            format.html do
              flash[:success] = flash_message_for(@object, :successfully_updated)
              if params[:create_user].present?
                if @object.user_ids.present?
                  redirect_to edit_admin_user_path(@object.users.first.id, vendor_id: @object.id) unless request.xhr?
                else
                  redirect_to new_admin_user_path(vendor_id: @object.id) unless request.xhr?
                end
              else
                redirect_to business_details_admin_vendors_url(id: @object.id) unless request.xhr?
              end
            end
            format.js { render layout: false }
          end
        else
          invoke_callbacks(:update, :fails)
          respond_with(@object) do |format|
            format.html { render action: :edit, status: :unprocessable_entity }
            format.js { render layout: false, status: :unprocessable_entity }
          end
        end
      end

      def business_details
      end

      def update_positions
        params[:positions].each do |id, position|
          vendor = Spree::Vendor.find(id)
          vendor.set_list_position(position)
        end

        respond_to do |format|
          format.js { render plain: 'Ok' }
        end
      end

      private

      def find_resource
        Vendor.with_deleted.friendly.find(params[:id])
      end

      def collection
        params[:q] = {} if params[:q].blank?
        vendors = super.order(priority: :asc)
        @search = vendors.ransack(params[:q])

        @collection = @search.result.
            includes(vendor_includes).
            page(params[:page]).
            per(params[:per_page])
      end

      def vendor_includes
        {
          image: [],
          products: []
        }
      end
    end
  end
end
