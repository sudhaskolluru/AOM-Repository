CREATE OR REPLACE PACKAGE BODY XXTRINITI_CREATE_ITEMS_PKG AS
  --G_PKG_NAME CONSTANT VARCHAR2(30) := 'XX_MTL_SYSTEM_ITEMS_PKG';
  G_MASTER_ORG_ID NUMBER;
  G_ORG_ID        NUMBER;
  ------------------------- GET_MASTER_ORG_ID ----------------------------------
  
  FUNCTION GET_MASTER_ORG_ID(P_ORG_ID IN NUMBER) RETURN NUMBER IS
  BEGIN
    IF ((G_MASTER_ORG_ID IS NULL) OR NOT (G_ORG_ID = P_ORG_ID)) THEN
      G_ORG_ID := P_ORG_ID;
      SELECT MASTER_ORGANIZATION_ID
        INTO G_MASTER_ORG_ID
        FROM MTL_PARAMETERS
       WHERE ORGANIZATION_ID = P_ORG_ID;
    END IF;
    RETURN(G_MASTER_ORG_ID);
  END GET_MASTER_ORG_ID;
  -- ------------------ INSERT_ROW -------------------
  
  PROCEDURE INSERT_ROW(X_BOM_COPY_ID         IN NUMBER,
                       X_USER_ID             IN VARCHAR2,
                       X_ROWID               IN OUT VARCHAR2,
                       X_INVENTORY_ITEM_ID   IN NUMBER,
                       X_ORGANIZATION_ID     IN NUMBER,
                       X_SRC_ORGANIZATION_ID IN NUMBER,
                       X_DESCRIPTION         IN VARCHAR2,
                       X_LONG_DESCRIPTION    IN VARCHAR2,
                       X_PRIMARY_UOM_CODE    IN VARCHAR2,
                       --  X_PRIMARY_UNIT_OF_MEASURE IN VARCHAR2,
                       X_ALLOWED_UNITS_LOOKUP_CODE    IN NUMBER,
                       X_OVERCOMPLETION_TOLERANCE_TYP IN NUMBER,
                       X_OVERCOMPLETION_TOLERANCE_VAL IN NUMBER,
                       X_EFFECTIVITY_CONTROL          IN NUMBER,
                       X_CHECK_SHORTAGES_FLAG         IN VARCHAR2,
                       X_FULL_LEAD_TIME               IN NUMBER,
                       X_ORDER_COST                   IN NUMBER,
                       X_MRP_SAFETY_STOCK_PERCENT     IN NUMBER,
                       X_MRP_SAFETY_STOCK_CODE        IN NUMBER,
                       X_MIN_MINMAX_QUANTITY          IN NUMBER,
                       X_MAX_MINMAX_QUANTITY          IN NUMBER,
                       X_MINIMUM_ORDER_QUANTITY       IN NUMBER,
                       X_FIXED_ORDER_QUANTITY         IN NUMBER,
                       X_FIXED_DAYS_SUPPLY            IN NUMBER,
                       X_MAXIMUM_ORDER_QUANTITY       IN NUMBER,
                       X_ATP_RULE_ID                  IN NUMBER,
                       X_PICKING_RULE_ID              IN NUMBER,
                       X_RESERVABLE_TYPE              IN NUMBER,
                       X_POSITIVE_MEASUREMENT_ERROR   IN NUMBER,
                       X_NEGATIVE_MEASUREMENT_ERROR   IN NUMBER,
                       X_ENGINEERING_ECN_CODE         IN VARCHAR2,
                       X_ENGINEERING_ITEM_ID          IN NUMBER,
                       X_ENGINEERING_DATE             IN DATE,
                       X_SERVICE_STARTING_DELAY       IN NUMBER,
                       X_SERVICEABLE_COMPONENT_FLAG   IN VARCHAR2,
                       X_SERVICEABLE_PRODUCT_FLAG     IN VARCHAR2,
                       --  X_BASE_WARRANTY_SERVICE_ID IN NUMBER,
                       X_PAYMENT_TERMS_ID            IN NUMBER,
                       X_PREVENTIVE_MAINTENANCE_FLAG IN VARCHAR2,
                       --  X_PRIMARY_SPECIALIST_ID IN NUMBER,
                       --  X_SECONDARY_SPECIALIST_ID IN NUMBER,
                       --  X_SERVICEABLE_ITEM_CLASS_ID IN NUMBER,
                       --  X_TIME_BILLABLE_FLAG IN VARCHAR2,
                       X_MATERIAL_BILLABLE_FLAG IN VARCHAR2,
                       --  X_EXPENSE_BILLABLE_FLAG IN VARCHAR2,
                       X_PRORATE_SERVICE_FLAG         IN VARCHAR2,
                       X_COVERAGE_SCHEDULE_ID         IN NUMBER,
                       X_SERVICE_DURATION_PERIOD_CODE IN VARCHAR2,
                       X_SERVICE_DURATION             IN NUMBER,
                       --  X_WARRANTY_VENDOR_ID IN NUMBER,
                       --  X_MAX_WARRANTY_AMOUNT IN NUMBER,
                       --  X_RESPONSE_TIME_PERIOD_CODE IN VARCHAR2,
                       --  X_RESPONSE_TIME_VALUE IN NUMBER,
                       --  X_NEW_REVISION_CODE IN VARCHAR2,
                       X_INVOICEABLE_ITEM_FLAG        IN VARCHAR2,
                       X_TAX_CODE                     IN VARCHAR2,
                       X_INVOICE_ENABLED_FLAG         IN VARCHAR2,
                       X_MUST_USE_APPROVED_VENDOR_FLA IN VARCHAR2,
                       --  X_REQUEST_ID IN NUMBER,
                       X_OUTSIDE_OPERATION_FLAG       IN VARCHAR2,
                       X_OUTSIDE_OPERATION_UOM_TYPE   IN VARCHAR2,
                       X_SAFETY_STOCK_BUCKET_DAYS     IN NUMBER,
                       X_AUTO_REDUCE_MPS              IN NUMBER,
                       X_COSTING_ENABLED_FLAG         IN VARCHAR2,
                       X_AUTO_CREATED_CONFIG_FLAG     IN VARCHAR2,
                       X_CYCLE_COUNT_ENABLED_FLAG     IN VARCHAR2,
                       X_ITEM_TYPE                    IN VARCHAR2,
                       X_MODEL_CONFIG_CLAUSE_NAME     IN VARCHAR2,
                       X_SHIP_MODEL_COMPLETE_FLAG     IN VARCHAR2,
                       X_MRP_PLANNING_CODE            IN NUMBER,
                       X_RETURN_INSPECTION_REQUIREMEN IN NUMBER,
                       X_ATO_FORECAST_CONTROL         IN NUMBER,
                       X_RELEASE_TIME_FENCE_CODE      IN NUMBER,
                       X_RELEASE_TIME_FENCE_DAYS      IN NUMBER,
                       X_CONTAINER_ITEM_FLAG          IN VARCHAR2,
                       X_VEHICLE_ITEM_FLAG            IN VARCHAR2,
                       X_MAXIMUM_LOAD_WEIGHT          IN NUMBER,
                       X_MINIMUM_FILL_PERCENT         IN NUMBER,
                       X_CONTAINER_TYPE_CODE          IN VARCHAR2,
                       X_INTERNAL_VOLUME              IN NUMBER,
                       --  X_WH_UPDATE_DATE IN DATE,
                       X_PRODUCT_FAMILY_ITEM_ID       IN NUMBER,
                       X_GLOBAL_ATTRIBUTE_CATEGORY    IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE1            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE2            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE3            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE4            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE5            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE6            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE7            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE8            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE9            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE10           IN VARCHAR2,
                       X_PURCHASING_TAX_CODE          IN VARCHAR2,
                       X_ATTRIBUTE6                   IN VARCHAR2,
                       X_ATTRIBUTE7                   IN VARCHAR2,
                       X_ATTRIBUTE8                   IN VARCHAR2,
                       X_ATTRIBUTE9                   IN VARCHAR2,
                       X_ATTRIBUTE10                  IN VARCHAR2,
                       X_ATTRIBUTE11                  IN VARCHAR2,
                       X_ATTRIBUTE12                  IN VARCHAR2,
                       X_ATTRIBUTE13                  IN VARCHAR2,
                       X_ATTRIBUTE14                  IN VARCHAR2,
                       X_ATTRIBUTE15                  IN VARCHAR2,
                       X_PURCHASING_ITEM_FLAG         IN VARCHAR2,
                       X_SHIPPABLE_ITEM_FLAG          IN VARCHAR2,
                       X_CUSTOMER_ORDER_FLAG          IN VARCHAR2,
                       X_INTERNAL_ORDER_FLAG          IN VARCHAR2,
                       X_INVENTORY_ITEM_FLAG          IN VARCHAR2,
                       X_ENG_ITEM_FLAG                IN VARCHAR2,
                       X_INVENTORY_ASSET_FLAG         IN VARCHAR2,
                       X_PURCHASING_ENABLED_FLAG      IN VARCHAR2,
                       X_CUSTOMER_ORDER_ENABLED_FLAG  IN VARCHAR2,
                       X_INTERNAL_ORDER_ENABLED_FLAG  IN VARCHAR2,
                       X_SO_TRANSACTIONS_FLAG         IN VARCHAR2,
                       X_MTL_TRANSACTIONS_ENABLED_FLA IN VARCHAR2,
                       X_STOCK_ENABLED_FLAG           IN VARCHAR2,
                       X_BOM_ENABLED_FLAG             IN VARCHAR2,
                       X_BUILD_IN_WIP_FLAG            IN VARCHAR2,
                       X_REVISION_QTY_CONTROL_CODE    IN NUMBER,
                       X_ITEM_CATALOG_GROUP_ID        IN NUMBER,
                       X_CATALOG_STATUS_FLAG          IN VARCHAR2,
                       X_RETURNABLE_FLAG              IN VARCHAR2,
                       X_DEFAULT_SHIPPING_ORG         IN NUMBER,
                       X_COLLATERAL_FLAG              IN VARCHAR2,
                       X_TAXABLE_FLAG                 IN VARCHAR2,
                       X_QTY_RCV_EXCEPTION_CODE       IN VARCHAR2,
                       X_ALLOW_ITEM_DESC_UPDATE_FLAG  IN VARCHAR2,
                       X_INSPECTION_REQUIRED_FLAG     IN VARCHAR2,
                       X_RECEIPT_REQUIRED_FLAG        IN VARCHAR2,
                       X_MARKET_PRICE                 IN NUMBER,
                       X_HAZARD_CLASS_ID              IN NUMBER,
                       X_RFQ_REQUIRED_FLAG            IN VARCHAR2,
                       X_QTY_RCV_TOLERANCE            IN NUMBER,
                       X_LIST_PRICE_PER_UNIT          IN NUMBER,
                       X_UN_NUMBER_ID                 IN NUMBER,
                       X_PRICE_TOLERANCE_PERCENT      IN NUMBER,
                       X_ASSET_CATEGORY_ID            IN NUMBER,
                       X_ROUNDING_FACTOR              IN NUMBER,
                       X_UNIT_OF_ISSUE                IN VARCHAR2,
                       X_ENFORCE_SHIP_TO_LOCATION_COD IN VARCHAR2,
                       X_ALLOW_SUBSTITUTE_RECEIPTS_FL IN VARCHAR2,
                       X_ALLOW_UNORDERED_RECEIPTS_FLA IN VARCHAR2,
                       X_ALLOW_EXPRESS_DELIVERY_FLAG  IN VARCHAR2,
                       X_DAYS_EARLY_RECEIPT_ALLOWED   IN NUMBER,
                       X_DAYS_LATE_RECEIPT_ALLOWED    IN NUMBER,
                       X_RECEIPT_DAYS_EXCEPTION_CODE  IN VARCHAR2,
                       X_RECEIVING_ROUTING_ID         IN NUMBER,
                       X_INVOICE_CLOSE_TOLERANCE      IN NUMBER,
                       X_RECEIVE_CLOSE_TOLERANCE      IN NUMBER,
                       X_AUTO_LOT_ALPHA_PREFIX        IN VARCHAR2,
                       X_START_AUTO_LOT_NUMBER        IN VARCHAR2,
                       X_LOT_CONTROL_CODE             IN NUMBER,
                       X_SHELF_LIFE_CODE              IN NUMBER,
                       X_SHELF_LIFE_DAYS              IN NUMBER,
                       X_SERIAL_NUMBER_CONTROL_CODE   IN NUMBER,
                       X_START_AUTO_SERIAL_NUMBER     IN VARCHAR2,
                       X_AUTO_SERIAL_ALPHA_PREFIX     IN VARCHAR2,
                       X_SOURCE_TYPE                  IN NUMBER,
                       X_SOURCE_ORGANIZATION_ID       IN NUMBER,
                       X_SOURCE_SUBINVENTORY          IN VARCHAR2,
                       X_EXPENSE_ACCOUNT              IN NUMBER,
                       X_ENCUMBRANCE_ACCOUNT          IN NUMBER,
                       X_RESTRICT_SUBINVENTORIES_CODE IN NUMBER,
                       X_UNIT_WEIGHT                  IN NUMBER,
                       X_WEIGHT_UOM_CODE              IN VARCHAR2,
                       X_VOLUME_UOM_CODE              IN VARCHAR2,
                       X_UNIT_VOLUME                  IN NUMBER,
                       X_RESTRICT_LOCATORS_CODE       IN NUMBER,
                       X_LOCATION_CONTROL_CODE        IN NUMBER,
                       X_SHRINKAGE_RATE               IN NUMBER,
                       X_ACCEPTABLE_EARLY_DAYS        IN NUMBER,
                       X_PLANNING_TIME_FENCE_CODE     IN NUMBER,
                       X_DEMAND_TIME_FENCE_CODE       IN NUMBER,
                       X_LEAD_TIME_LOT_SIZE           IN NUMBER,
                       X_STD_LOT_SIZE                 IN NUMBER,
                       X_CUM_MANUFACTURING_LEAD_TIME  IN NUMBER,
                       X_OVERRUN_PERCENTAGE           IN NUMBER,
                       X_MRP_CALCULATE_ATP_FLAG       IN VARCHAR2,
                       X_ACCEPTABLE_RATE_INCREASE     IN NUMBER,
                       X_ACCEPTABLE_RATE_DECREASE     IN NUMBER,
                       X_CUMULATIVE_TOTAL_LEAD_TIME   IN NUMBER,
                       X_PLANNING_TIME_FENCE_DAYS     IN NUMBER,
                       X_DEMAND_TIME_FENCE_DAYS       IN NUMBER,
                       X_END_ASSEMBLY_PEGGING_FLAG    IN VARCHAR2,
                       X_REPETITIVE_PLANNING_FLAG     IN VARCHAR2,
                       X_PLANNING_EXCEPTION_SET       IN VARCHAR2,
                       X_BOM_ITEM_TYPE                IN NUMBER,
                       X_PICK_COMPONENTS_FLAG         IN VARCHAR2,
                       X_REPLENISH_TO_ORDER_FLAG      IN VARCHAR2,
                       X_BASE_ITEM_ID                 IN NUMBER,
                       X_ATP_COMPONENTS_FLAG          IN VARCHAR2,
                       X_ATP_FLAG                     IN VARCHAR2,
                       X_FIXED_LEAD_TIME              IN NUMBER,
                       X_VARIABLE_LEAD_TIME           IN NUMBER,
                       X_WIP_SUPPLY_LOCATOR_ID        IN NUMBER,
                       X_WIP_SUPPLY_TYPE              IN NUMBER,
                       X_WIP_SUPPLY_SUBINVENTORY      IN VARCHAR2,
                       X_COST_OF_SALES_ACCOUNT        IN NUMBER,
                       X_SALES_ACCOUNT                IN NUMBER,
                       X_DEFAULT_INCLUDE_IN_ROLLUP_FL IN VARCHAR2,
                       X_INVENTORY_ITEM_STATUS_CODE   IN VARCHAR2,
                       X_INVENTORY_PLANNING_CODE      IN NUMBER,
                       X_PLANNER_CODE                 IN VARCHAR2,
                       X_PLANNING_MAKE_BUY_CODE       IN NUMBER,
                       X_FIXED_LOT_MULTIPLIER         IN NUMBER,
                       X_ROUNDING_CONTROL_TYPE        IN NUMBER,
                       X_CARRYING_COST                IN NUMBER,
                       X_POSTPROCESSING_LEAD_TIME     IN NUMBER,
                       X_PREPROCESSING_LEAD_TIME      IN NUMBER,
                       X_SUMMARY_FLAG                 IN VARCHAR2,
                       X_ENABLED_FLAG                 IN VARCHAR2,
                       X_START_DATE_ACTIVE            IN DATE,
                       X_END_DATE_ACTIVE              IN DATE,
                       X_BUYER_ID                     IN NUMBER,
                       X_ACCOUNTING_RULE_ID           IN NUMBER,
                       X_INVOICING_RULE_ID            IN NUMBER,
                       X_OVER_SHIPMENT_TOLERANCE      IN NUMBER,
                       X_UNDER_SHIPMENT_TOLERANCE     IN NUMBER,
                       X_OVER_RETURN_TOLERANCE        IN NUMBER,
                       X_UNDER_RETURN_TOLERANCE       IN NUMBER,
                       X_EQUIPMENT_TYPE               IN NUMBER,
                       X_RECOVERED_PART_DISP_CODE     IN VARCHAR2,
                       X_DEFECT_TRACKING_ON_FLAG      IN VARCHAR2,
                       X_EVENT_FLAG                   IN VARCHAR2,
                       X_ELECTRONIC_FLAG              IN VARCHAR2,
                       X_DOWNLOADABLE_FLAG            IN VARCHAR2,
                       X_VOL_DISCOUNT_EXEMPT_FLAG     IN VARCHAR2,
                       X_COUPON_EXEMPT_FLAG           IN VARCHAR2,
                       X_COMMS_NL_TRACKABLE_FLAG      IN VARCHAR2,
                       X_ASSET_CREATION_CODE          IN VARCHAR2,
                       X_COMMS_ACTIVATION_REQD_FLAG   IN VARCHAR2,
                       X_ORDERABLE_ON_WEB_FLAG        IN VARCHAR2,
                       X_BACK_ORDERABLE_FLAG          IN VARCHAR2,
                       X_WEB_STATUS                   IN VARCHAR2,
                       X_INDIVISIBLE_FLAG             IN VARCHAR2,
                       X_DIMENSION_UOM_CODE           IN VARCHAR2,
                       X_UNIT_LENGTH                  IN NUMBER,
                       X_UNIT_WIDTH                   IN NUMBER,
                       X_UNIT_HEIGHT                  IN NUMBER,
                       X_BULK_PICKED_FLAG             IN VARCHAR2,
                       X_LOT_STATUS_ENABLED           IN VARCHAR2,
                       X_DEFAULT_LOT_STATUS_ID        IN NUMBER,
                       X_SERIAL_STATUS_ENABLED        IN VARCHAR2,
                       X_DEFAULT_SERIAL_STATUS_ID     IN NUMBER,
                       X_LOT_SPLIT_ENABLED            IN VARCHAR2,
                       X_LOT_MERGE_ENABLED            IN VARCHAR2,
                       X_INVENTORY_CARRY_PENALTY      IN NUMBER,
                       X_OPERATION_SLACK_PENALTY      IN NUMBER,
                       X_FINANCING_ALLOWED_FLAG       IN VARCHAR2,
                       X_EAM_ITEM_TYPE                IN NUMBER,
                       X_EAM_ACTIVITY_TYPE_CODE       IN VARCHAR2,
                       X_EAM_ACTIVITY_CAUSE_CODE      IN VARCHAR2,
                       X_EAM_ACT_NOTIFICATION_FLAG    IN VARCHAR2,
                       X_EAM_ACT_SHUTDOWN_STATUS      IN VARCHAR2,
                       X_DUAL_UOM_CONTROL             IN NUMBER,
                       X_SECONDARY_UOM_CODE           IN VARCHAR2,
                       X_DUAL_UOM_DEVIATION_HIGH      IN NUMBER,
                       X_DUAL_UOM_DEVIATION_LOW       IN NUMBER
                       --,  X_SERVICE_ITEM_FLAG          IN   VARCHAR2
                       --,  X_VENDOR_WARRANTY_FLAG       IN   VARCHAR2
                       --,  X_USAGE_ITEM_FLAG            IN   VARCHAR2
                      ,
                       X_CONTRACT_ITEM_TYPE_CODE   IN VARCHAR2,
                       X_SUBSCRIPTION_DEPEND_FLAG  IN VARCHAR2,
                       X_SERV_REQ_ENABLED_CODE     IN VARCHAR2,
                       X_SERV_BILLING_ENABLED_FLAG IN VARCHAR2,
                       X_SERV_IMPORTANCE_LEVEL     IN NUMBER,
                       X_PLANNED_INV_POINT_FLAG    IN VARCHAR2,
                       X_LOT_TRANSLATE_ENABLED     IN VARCHAR2,
                       X_DEFAULT_SO_SOURCE_TYPE    IN VARCHAR2,
                       X_CREATE_SUPPLY_FLAG        IN VARCHAR2,
                       X_SUBSTITUTION_WINDOW_CODE  IN NUMBER,
                       X_SUBSTITUTION_WINDOW_DAYS  IN NUMBER,
                       X_SEGMENT1                  IN VARCHAR2,
                       X_SEGMENT2                  IN VARCHAR2,
                       X_SEGMENT3                  IN VARCHAR2,
                       X_SEGMENT4                  IN VARCHAR2,
                       X_SEGMENT5                  IN VARCHAR2,
                       X_SEGMENT6                  IN VARCHAR2,
                       X_SEGMENT7                  IN VARCHAR2,
                       X_SEGMENT8                  IN VARCHAR2,
                       X_SEGMENT9                  IN VARCHAR2,
                       X_SEGMENT10                 IN VARCHAR2,
                       X_SEGMENT11                 IN VARCHAR2,
                       X_SEGMENT12                 IN VARCHAR2,
                       X_SEGMENT13                 IN VARCHAR2,
                       X_SEGMENT14                 IN VARCHAR2,
                       X_SEGMENT15                 IN VARCHAR2,
                       X_SEGMENT16                 IN VARCHAR2,
                       X_SEGMENT17                 IN VARCHAR2,
                       X_SEGMENT18                 IN VARCHAR2,
                       X_SEGMENT19                 IN VARCHAR2,
                       X_SEGMENT20                 IN VARCHAR2,
                       X_ATTRIBUTE_CATEGORY        IN VARCHAR2,
                       X_ATTRIBUTE1                IN VARCHAR2,
                       X_ATTRIBUTE2                IN VARCHAR2,
                       X_ATTRIBUTE3                IN VARCHAR2,
                       X_ATTRIBUTE4                IN VARCHAR2,
                       X_ATTRIBUTE5                IN VARCHAR2,
                       X_CREATION_DATE             IN DATE,
                       X_CREATED_BY                IN NUMBER,
                       X_LAST_UPDATE_DATE          IN DATE,
                       X_LAST_UPDATED_BY           IN NUMBER,
                       X_LAST_UPDATE_LOGIN         IN NUMBER,
                       --X_PROGRAM_UPDATE_DATE IN DATE,
                       --X_OBJECT_VERSION_NUMBER IN  NUMBER,
                       X_TRACKING_QUANTITY_IND    IN VARCHAR2,
                       X_ONT_PRICING_QTY_SOURCE   IN VARCHAR2,
                       X_CONSIGNED_FLAG           IN NUMBER,
                       X_ASN_AUTOEXPIRE_FLAG      IN NUMBER,
                       X_VMI_FORECAST_TYPE        IN NUMBER,
                       X_EXCLUDE_FROM_BUDGET_FLAG IN NUMBER,
                       X_DRP_PLANNED_FLAG         IN NUMBER,
                       X_CRITICAL_COMPONENT_FLAG  IN NUMBER,
                       X_CONTINOUS_TRANSFER       IN NUMBER,
                       X_CONVERGENCE              IN NUMBER,
                       X_DIVERGENCE               IN NUMBER) IS
    CURSOR C IS
      SELECT ROWID
        FROM MTL_SYSTEM_ITEMS_B
       WHERE INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
         AND ORGANIZATION_ID = X_ORGANIZATION_ID;
    L_INVENTORY_ITEM_ID NUMBER := X_INVENTORY_ITEM_ID;
    L_ORGANIZATION_ID   NUMBER := X_ORGANIZATION_ID;
    L_RETURN_STATUS VARCHAR2(1);
    L_MSG_COUNT     NUMBER;
    L_MSG_DATA      VARCHAR2(2000);
    -- VARIABLES HOLDING DERIVED ATTRIBUTE VALUES.
    L_PRIMARY_UNIT_OF_MEASURE VARCHAR2(25);
    L_SERVICE_ITEM_FLAG       VARCHAR2(1);
    L_VENDOR_WARRANTY_FLAG    VARCHAR2(1);
    L_USAGE_ITEM_FLAG         VARCHAR2(1);
    L_ERRBUF                  VARCHAR2(2000);
    l_retcode                 number;
    t_error_code              NUMBER;
    t_COUNT                   NUMBER;
    t_error_message           VARCHAR2(2000);
    l_set_prc_id              NUMBER;
    L_target_org_code         VARCHAR2(25);
    t_rev_count               number;
    l_login_appln_id          number;
    l_login_resp_id           number;
    L_PLANNER_CODE            VARCHAR2(25);
    --L_DEFAULT_SO_SOURCE_TYPE   VARCHAR2(30)  :=  'INTERNAL';
    --L_CREATE_SUPPLY_FLAG       VARCHAR2(1)   :=  'Y';
  BEGIN
    -- PRIMARY_UNIT_OF_MEASURE LOOKUP
    SELECT UNIT_OF_MEASURE
      INTO L_PRIMARY_UNIT_OF_MEASURE
      FROM MTL_UNITS_OF_MEASURE_VL
     WHERE UOM_CODE = X_PRIMARY_UOM_CODE;
    --GETTING  TARGET_ORG CODE
    select organization_code
      into l_target_org_code
      from mtl_parameters
     where organization_id = X_ORGANIZATION_ID;
    -- Checking if Planner code Valid for target organization
    BEGIN
      select planner_code
        into L_PLANNER_CODE
        from MTL_Planners
       where organization_id = X_ORGANIZATION_ID
         and planner_code = X_PLANNER_CODE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- If the planner does not exist then leave it blank and proceed with ITEM Copy
        L_PLANNER_CODE := NULL;
    END;
    --
    -- GET DERIVED ATTRIBUTE VALUES.
    -- SERVICE ITEM, WARRANTY, USAGE FLAG ATTRIBUTES ARE DEPENDENT ON
    -- AND DERIVED FROM CONTRACT ITEM TYPE; SUPPORTED FOR VIEW ONLY.
    /*Commented By Vishnu on 01/08/2015
      Below logic is copied from ITEM API, if interface is populated with X_CONTRACT_ITEM_TYPE_CODE, API would automatically
      take care of deriving the values for SERVICE_ITEM_FLAG,VENDOR_WARRANTY_FLAG,USAGE_ITEM_FLAG
    */
    /* IF (X_CONTRACT_ITEM_TYPE_CODE = 'SERVICE') THEN
      L_SERVICE_ITEM_FLAG    := 'Y';
      L_VENDOR_WARRANTY_FLAG := 'N';
      L_USAGE_ITEM_FLAG      := NULL;
    ELSIF (X_CONTRACT_ITEM_TYPE_CODE = 'WARRANTY') THEN
      L_SERVICE_ITEM_FLAG    := 'Y';
      L_VENDOR_WARRANTY_FLAG := 'Y';
      L_USAGE_ITEM_FLAG      := NULL;
    ELSIF (X_CONTRACT_ITEM_TYPE_CODE = 'USAGE') THEN
      L_SERVICE_ITEM_FLAG    := 'N';
      L_VENDOR_WARRANTY_FLAG := 'N';
      L_USAGE_ITEM_FLAG      := 'Y';
    ELSE
      L_SERVICE_ITEM_FLAG    := 'N';
      L_VENDOR_WARRANTY_FLAG := 'N';
      L_USAGE_ITEM_FLAG      := NULL;
    END IF;*/
    --getting set_process_id to be populated into IFACE
    SELECT mtl_system_items_intf_sets_s.nextval
      INTO l_set_prc_id
      FROM DUAL;
    --Inserting Item Details into iface
    BEGIN
      INSERT INTO MTL_SYSTEM_ITEMS_INTERFACE --MTL_SYSTEM_ITEMS_B
        (PROCESS_FLAG,
         SET_PROCESS_ID,
         TRANSACTION_TYPE,
         DESCRIPTION,
         INVENTORY_ITEM_ID,
         ORGANIZATION_ID,
         SUMMARY_FLAG,
         ENABLED_FLAG,
         START_DATE_ACTIVE,
         END_DATE_ACTIVE,
         PRIMARY_UOM_CODE,
         PRIMARY_UNIT_OF_MEASURE,
         ALLOWED_UNITS_LOOKUP_CODE,
         OVERCOMPLETION_TOLERANCE_TYPE,
         OVERCOMPLETION_TOLERANCE_VALUE,
         EFFECTIVITY_CONTROL,
         CHECK_SHORTAGES_FLAG,
         FULL_LEAD_TIME,
         ORDER_COST,
         MRP_SAFETY_STOCK_PERCENT,
         MRP_SAFETY_STOCK_CODE,
         MIN_MINMAX_QUANTITY,
         MAX_MINMAX_QUANTITY,
         MINIMUM_ORDER_QUANTITY,
         FIXED_ORDER_QUANTITY,
         FIXED_DAYS_SUPPLY,
         MAXIMUM_ORDER_QUANTITY,
         ATP_RULE_ID,
         PICKING_RULE_ID,
         RESERVABLE_TYPE,
         POSITIVE_MEASUREMENT_ERROR,
         NEGATIVE_MEASUREMENT_ERROR,
         ENGINEERING_ECN_CODE,
         ENGINEERING_ITEM_ID,
         ENGINEERING_DATE,
         SERVICE_STARTING_DELAY,
         SERVICEABLE_COMPONENT_FLAG,
         SERVICEABLE_PRODUCT_FLAG,
         --    BASE_WARRANTY_SERVICE_ID,
         PAYMENT_TERMS_ID,
         PREVENTIVE_MAINTENANCE_FLAG,
         --    PRIMARY_SPECIALIST_ID,
         --    SECONDARY_SPECIALIST_ID,
         --    SERVICEABLE_ITEM_CLASS_ID,
         --    TIME_BILLABLE_FLAG,
         MATERIAL_BILLABLE_FLAG,
         --    EXPENSE_BILLABLE_FLAG,
         PRORATE_SERVICE_FLAG,
         COVERAGE_SCHEDULE_ID,
         SERVICE_DURATION_PERIOD_CODE,
         SERVICE_DURATION,
         --    WARRANTY_VENDOR_ID,
         --    MAX_WARRANTY_AMOUNT,
         --    RESPONSE_TIME_PERIOD_CODE,
         --    RESPONSE_TIME_VALUE,
         --    NEW_REVISION_CODE,
         INVOICEABLE_ITEM_FLAG,
         TAX_CODE,
         INVOICE_ENABLED_FLAG,
         MUST_USE_APPROVED_VENDOR_FLAG,
         --    REQUEST_ID,
         OUTSIDE_OPERATION_FLAG,
         OUTSIDE_OPERATION_UOM_TYPE,
         SAFETY_STOCK_BUCKET_DAYS,
         AUTO_REDUCE_MPS,
         COSTING_ENABLED_FLAG,
         AUTO_CREATED_CONFIG_FLAG,
         CYCLE_COUNT_ENABLED_FLAG,
         ITEM_TYPE,
         MODEL_CONFIG_CLAUSE_NAME,
         SHIP_MODEL_COMPLETE_FLAG,
         MRP_PLANNING_CODE,
         RETURN_INSPECTION_REQUIREMENT,
         ATO_FORECAST_CONTROL,
         RELEASE_TIME_FENCE_CODE,
         RELEASE_TIME_FENCE_DAYS,
         CONTAINER_ITEM_FLAG,
         VEHICLE_ITEM_FLAG,
         MAXIMUM_LOAD_WEIGHT,
         MINIMUM_FILL_PERCENT,
         CONTAINER_TYPE_CODE,
         INTERNAL_VOLUME,
         --    WH_UPDATE_DATE,
         PRODUCT_FAMILY_ITEM_ID,
         GLOBAL_ATTRIBUTE_CATEGORY,
         GLOBAL_ATTRIBUTE1,
         GLOBAL_ATTRIBUTE2,
         GLOBAL_ATTRIBUTE3,
         GLOBAL_ATTRIBUTE4,
         GLOBAL_ATTRIBUTE5,
         GLOBAL_ATTRIBUTE6,
         GLOBAL_ATTRIBUTE7,
         GLOBAL_ATTRIBUTE8,
         GLOBAL_ATTRIBUTE9,
         GLOBAL_ATTRIBUTE10,
         PURCHASING_TAX_CODE,
         ATTRIBUTE6,
         ATTRIBUTE7,
         ATTRIBUTE8,
         ATTRIBUTE9,
         ATTRIBUTE10,
         ATTRIBUTE11,
         ATTRIBUTE12,
         ATTRIBUTE13,
         ATTRIBUTE14,
         ATTRIBUTE15,
         PURCHASING_ITEM_FLAG,
         SHIPPABLE_ITEM_FLAG,
         CUSTOMER_ORDER_FLAG,
         INTERNAL_ORDER_FLAG,
         INVENTORY_ITEM_FLAG,
         ENG_ITEM_FLAG,
         INVENTORY_ASSET_FLAG,
         PURCHASING_ENABLED_FLAG,
         CUSTOMER_ORDER_ENABLED_FLAG,
         INTERNAL_ORDER_ENABLED_FLAG,
         SO_TRANSACTIONS_FLAG,
         MTL_TRANSACTIONS_ENABLED_FLAG,
         STOCK_ENABLED_FLAG,
         BOM_ENABLED_FLAG,
         BUILD_IN_WIP_FLAG,
         REVISION_QTY_CONTROL_CODE,
         ITEM_CATALOG_GROUP_ID,
         CATALOG_STATUS_FLAG,
         RETURNABLE_FLAG,
         DEFAULT_SHIPPING_ORG,
         COLLATERAL_FLAG,
         TAXABLE_FLAG,
         QTY_RCV_EXCEPTION_CODE,
         ALLOW_ITEM_DESC_UPDATE_FLAG,
         INSPECTION_REQUIRED_FLAG,
         RECEIPT_REQUIRED_FLAG,
         MARKET_PRICE,
         HAZARD_CLASS_ID,
         RFQ_REQUIRED_FLAG,
         QTY_RCV_TOLERANCE,
         LIST_PRICE_PER_UNIT,
         UN_NUMBER_ID,
         PRICE_TOLERANCE_PERCENT,
         ASSET_CATEGORY_ID,
         ROUNDING_FACTOR,
         UNIT_OF_ISSUE,
         ENFORCE_SHIP_TO_LOCATION_CODE,
         ALLOW_SUBSTITUTE_RECEIPTS_FLAG,
         ALLOW_UNORDERED_RECEIPTS_FLAG,
         ALLOW_EXPRESS_DELIVERY_FLAG,
         DAYS_EARLY_RECEIPT_ALLOWED,
         DAYS_LATE_RECEIPT_ALLOWED,
         RECEIPT_DAYS_EXCEPTION_CODE,
         RECEIVING_ROUTING_ID,
         INVOICE_CLOSE_TOLERANCE,
         RECEIVE_CLOSE_TOLERANCE,
         AUTO_LOT_ALPHA_PREFIX,
         START_AUTO_LOT_NUMBER,
         LOT_CONTROL_CODE,
         SHELF_LIFE_CODE,
         SHELF_LIFE_DAYS,
         SERIAL_NUMBER_CONTROL_CODE,
         START_AUTO_SERIAL_NUMBER,
         AUTO_SERIAL_ALPHA_PREFIX,
         SOURCE_TYPE,
         SOURCE_ORGANIZATION_ID,
         SOURCE_SUBINVENTORY,
         EXPENSE_ACCOUNT,
         ENCUMBRANCE_ACCOUNT,
         RESTRICT_SUBINVENTORIES_CODE,
         UNIT_WEIGHT,
         WEIGHT_UOM_CODE,
         VOLUME_UOM_CODE,
         UNIT_VOLUME,
         RESTRICT_LOCATORS_CODE,
         LOCATION_CONTROL_CODE,
         SHRINKAGE_RATE,
         ACCEPTABLE_EARLY_DAYS,
         PLANNING_TIME_FENCE_CODE,
         DEMAND_TIME_FENCE_CODE,
         LEAD_TIME_LOT_SIZE,
         STD_LOT_SIZE,
         CUM_MANUFACTURING_LEAD_TIME,
         OVERRUN_PERCENTAGE,
         MRP_CALCULATE_ATP_FLAG,
         ACCEPTABLE_RATE_INCREASE,
         ACCEPTABLE_RATE_DECREASE,
         CUMULATIVE_TOTAL_LEAD_TIME,
         PLANNING_TIME_FENCE_DAYS,
         DEMAND_TIME_FENCE_DAYS,
         END_ASSEMBLY_PEGGING_FLAG,
         REPETITIVE_PLANNING_FLAG,
         PLANNING_EXCEPTION_SET,
         BOM_ITEM_TYPE,
         PICK_COMPONENTS_FLAG,
         REPLENISH_TO_ORDER_FLAG,
         BASE_ITEM_ID,
         ATP_COMPONENTS_FLAG,
         ATP_FLAG,
         FIXED_LEAD_TIME,
         VARIABLE_LEAD_TIME,
         --WIP_SUPPLY_LOCATOR_ID, --Cannot be same for Source Org and Destination org hence should not be populated into IFACE
         WIP_SUPPLY_TYPE,
         --WIP_SUPPLY_SUBINVENTORY, --Cannot be same for Source Org and Destination org hence should not be populated into IFACE
         COST_OF_SALES_ACCOUNT,
         SALES_ACCOUNT,
         DEFAULT_INCLUDE_IN_ROLLUP_FLAG,
         INVENTORY_ITEM_STATUS_CODE,
         INVENTORY_PLANNING_CODE,
         PLANNER_CODE,
         PLANNING_MAKE_BUY_CODE,
         FIXED_LOT_MULTIPLIER,
         ROUNDING_CONTROL_TYPE,
         CARRYING_COST,
         POSTPROCESSING_LEAD_TIME,
         PREPROCESSING_LEAD_TIME,
         BUYER_ID,
         ACCOUNTING_RULE_ID,
         INVOICING_RULE_ID,
         OVER_SHIPMENT_TOLERANCE,
         UNDER_SHIPMENT_TOLERANCE,
         OVER_RETURN_TOLERANCE,
         UNDER_RETURN_TOLERANCE,
         EQUIPMENT_TYPE,
         RECOVERED_PART_DISP_CODE,
         DEFECT_TRACKING_ON_FLAG,
         EVENT_FLAG,
         ELECTRONIC_FLAG,
         DOWNLOADABLE_FLAG,
         VOL_DISCOUNT_EXEMPT_FLAG,
         COUPON_EXEMPT_FLAG,
         COMMS_NL_TRACKABLE_FLAG,
         ASSET_CREATION_CODE,
         COMMS_ACTIVATION_REQD_FLAG,
         ORDERABLE_ON_WEB_FLAG,
         BACK_ORDERABLE_FLAG,
         WEB_STATUS,
         INDIVISIBLE_FLAG,
         DIMENSION_UOM_CODE,
         UNIT_LENGTH,
         UNIT_WIDTH,
         UNIT_HEIGHT,
         BULK_PICKED_FLAG,
         LOT_STATUS_ENABLED,
         DEFAULT_LOT_STATUS_ID,
         SERIAL_STATUS_ENABLED,
         DEFAULT_SERIAL_STATUS_ID,
         LOT_SPLIT_ENABLED,
         LOT_MERGE_ENABLED,
         INVENTORY_CARRY_PENALTY,
         OPERATION_SLACK_PENALTY,
         FINANCING_ALLOWED_FLAG,
         EAM_ITEM_TYPE,
         EAM_ACTIVITY_TYPE_CODE,
         EAM_ACTIVITY_CAUSE_CODE,
         EAM_ACT_NOTIFICATION_FLAG,
         EAM_ACT_SHUTDOWN_STATUS,
         DUAL_UOM_CONTROL,
         SECONDARY_UOM_CODE,
         DUAL_UOM_DEVIATION_HIGH,
         DUAL_UOM_DEVIATION_LOW,
         /*SERVICE_ITEM_FLAG,
         VENDOR_WARRANTY_FLAG,
         USAGE_ITEM_FLAG,*/
         CONTRACT_ITEM_TYPE_CODE,
         SUBSCRIPTION_DEPEND_FLAG,
         SERV_REQ_ENABLED_CODE,
         SERV_BILLING_ENABLED_FLAG,
         SERV_IMPORTANCE_LEVEL,
         PLANNED_INV_POINT_FLAG,
         LOT_TRANSLATE_ENABLED,
         DEFAULT_SO_SOURCE_TYPE,
         CREATE_SUPPLY_FLAG,
         SUBSTITUTION_WINDOW_CODE,
         SUBSTITUTION_WINDOW_DAYS,
         SEGMENT1,
         SEGMENT2,
         SEGMENT3,
         SEGMENT4,
         SEGMENT5,
         SEGMENT6,
         SEGMENT7,
         SEGMENT8,
         SEGMENT9,
         SEGMENT10,
         SEGMENT11,
         SEGMENT12,
         SEGMENT13,
         SEGMENT14,
         SEGMENT15,
         SEGMENT16,
         SEGMENT17,
         SEGMENT18,
         SEGMENT19,
         SEGMENT20,
         ATTRIBUTE_CATEGORY,
         ATTRIBUTE1,
         ATTRIBUTE2,
         ATTRIBUTE3,
         ATTRIBUTE4,
         ATTRIBUTE5,
         CREATION_DATE,
         CREATED_BY,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         LAST_UPDATE_LOGIN,
         --   PROGRAM_UPDATE_DATE ,
         --OBJECT_VERSION_NUMBER ,
         TRACKING_QUANTITY_IND,
         ONT_PRICING_QTY_SOURCE,
         CONSIGNED_FLAG,
         ASN_AUTOEXPIRE_FLAG,
         VMI_FORECAST_TYPE,
         EXCLUDE_FROM_BUDGET_FLAG,
         DRP_PLANNED_FLAG,
         CRITICAL_COMPONENT_FLAG,
         CONTINOUS_TRANSFER,
         CONVERGENCE,
         DIVERGENCE
         )
      VALUES
        (1,
         l_set_prc_id,
         'CREATE',
         X_DESCRIPTION,
         X_INVENTORY_ITEM_ID,
         X_ORGANIZATION_ID,
         X_SUMMARY_FLAG,
         X_ENABLED_FLAG,
         X_START_DATE_ACTIVE,
         X_END_DATE_ACTIVE,
         X_PRIMARY_UOM_CODE,
         L_PRIMARY_UNIT_OF_MEASURE,
         X_ALLOWED_UNITS_LOOKUP_CODE,
         X_OVERCOMPLETION_TOLERANCE_TYP,
         X_OVERCOMPLETION_TOLERANCE_VAL,
         X_EFFECTIVITY_CONTROL,
         X_CHECK_SHORTAGES_FLAG,
         X_FULL_LEAD_TIME,
         X_ORDER_COST,
         X_MRP_SAFETY_STOCK_PERCENT,
         X_MRP_SAFETY_STOCK_CODE,
         X_MIN_MINMAX_QUANTITY,
         X_MAX_MINMAX_QUANTITY,
         X_MINIMUM_ORDER_QUANTITY,
         X_FIXED_ORDER_QUANTITY,
         X_FIXED_DAYS_SUPPLY,
         X_MAXIMUM_ORDER_QUANTITY,
         X_ATP_RULE_ID,
         X_PICKING_RULE_ID,
         X_RESERVABLE_TYPE,
         X_POSITIVE_MEASUREMENT_ERROR,
         X_NEGATIVE_MEASUREMENT_ERROR,
         X_ENGINEERING_ECN_CODE,
         X_ENGINEERING_ITEM_ID,
         X_ENGINEERING_DATE,
         X_SERVICE_STARTING_DELAY,
         X_SERVICEABLE_COMPONENT_FLAG,
         X_SERVICEABLE_PRODUCT_FLAG,
         --    X_BASE_WARRANTY_SERVICE_ID,
         X_PAYMENT_TERMS_ID,
         X_PREVENTIVE_MAINTENANCE_FLAG,
         --    X_PRIMARY_SPECIALIST_ID,
         --    X_SECONDARY_SPECIALIST_ID,
         --    X_SERVICEABLE_ITEM_CLASS_ID,
         --    X_TIME_BILLABLE_FLAG,
         X_MATERIAL_BILLABLE_FLAG,
         --    X_EXPENSE_BILLABLE_FLAG,
         X_PRORATE_SERVICE_FLAG,
         X_COVERAGE_SCHEDULE_ID,
         X_SERVICE_DURATION_PERIOD_CODE,
         X_SERVICE_DURATION,
         --    X_WARRANTY_VENDOR_ID,
         --    X_MAX_WARRANTY_AMOUNT,
         --    X_RESPONSE_TIME_PERIOD_CODE,
         --    X_RESPONSE_TIME_VALUE,
         --    X_NEW_REVISION_CODE,
         X_INVOICEABLE_ITEM_FLAG,
         X_TAX_CODE,
         X_INVOICE_ENABLED_FLAG,
         X_MUST_USE_APPROVED_VENDOR_FLA,
         --    X_REQUEST_ID,
         X_OUTSIDE_OPERATION_FLAG,
         X_OUTSIDE_OPERATION_UOM_TYPE,
         X_SAFETY_STOCK_BUCKET_DAYS,
         X_AUTO_REDUCE_MPS,
         X_COSTING_ENABLED_FLAG,
         X_AUTO_CREATED_CONFIG_FLAG,
         X_CYCLE_COUNT_ENABLED_FLAG,
         X_ITEM_TYPE,
         X_MODEL_CONFIG_CLAUSE_NAME,
         X_SHIP_MODEL_COMPLETE_FLAG,
         X_MRP_PLANNING_CODE,
         X_RETURN_INSPECTION_REQUIREMEN,
         X_ATO_FORECAST_CONTROL,
         X_RELEASE_TIME_FENCE_CODE,
         X_RELEASE_TIME_FENCE_DAYS,
         X_CONTAINER_ITEM_FLAG,
         X_VEHICLE_ITEM_FLAG,
         X_MAXIMUM_LOAD_WEIGHT,
         X_MINIMUM_FILL_PERCENT,
         X_CONTAINER_TYPE_CODE,
         X_INTERNAL_VOLUME,
         --    X_WH_UPDATE_DATE,
         X_PRODUCT_FAMILY_ITEM_ID,
         X_GLOBAL_ATTRIBUTE_CATEGORY,
         X_GLOBAL_ATTRIBUTE1,
         X_GLOBAL_ATTRIBUTE2,
         X_GLOBAL_ATTRIBUTE3,
         X_GLOBAL_ATTRIBUTE4,
         X_GLOBAL_ATTRIBUTE5,
         X_GLOBAL_ATTRIBUTE6,
         X_GLOBAL_ATTRIBUTE7,
         X_GLOBAL_ATTRIBUTE8,
         X_GLOBAL_ATTRIBUTE9,
         X_GLOBAL_ATTRIBUTE10,
         X_PURCHASING_TAX_CODE,
         X_ATTRIBUTE6,
         X_ATTRIBUTE7,
         X_ATTRIBUTE8,
         X_ATTRIBUTE9,
         X_ATTRIBUTE10,
         X_ATTRIBUTE11,
         X_ATTRIBUTE12,
         X_ATTRIBUTE13,
         X_ATTRIBUTE14,
         X_ATTRIBUTE15,
         X_PURCHASING_ITEM_FLAG,
         X_SHIPPABLE_ITEM_FLAG,
         X_CUSTOMER_ORDER_FLAG,
         X_INTERNAL_ORDER_FLAG,
         X_INVENTORY_ITEM_FLAG,
         X_ENG_ITEM_FLAG,
         X_INVENTORY_ASSET_FLAG,
         X_PURCHASING_ENABLED_FLAG,
         X_CUSTOMER_ORDER_ENABLED_FLAG,
         X_INTERNAL_ORDER_ENABLED_FLAG,
         X_SO_TRANSACTIONS_FLAG,
         X_MTL_TRANSACTIONS_ENABLED_FLA,
         X_STOCK_ENABLED_FLAG,
         X_BOM_ENABLED_FLAG,
         X_BUILD_IN_WIP_FLAG,
         X_REVISION_QTY_CONTROL_CODE,
         X_ITEM_CATALOG_GROUP_ID,
         X_CATALOG_STATUS_FLAG,
         X_RETURNABLE_FLAG,
         X_DEFAULT_SHIPPING_ORG,
         X_COLLATERAL_FLAG,
         X_TAXABLE_FLAG,
         X_QTY_RCV_EXCEPTION_CODE,
         X_ALLOW_ITEM_DESC_UPDATE_FLAG,
         X_INSPECTION_REQUIRED_FLAG,
         X_RECEIPT_REQUIRED_FLAG,
         X_MARKET_PRICE,
         X_HAZARD_CLASS_ID,
         X_RFQ_REQUIRED_FLAG,
         X_QTY_RCV_TOLERANCE,
         X_LIST_PRICE_PER_UNIT,
         X_UN_NUMBER_ID,
         X_PRICE_TOLERANCE_PERCENT,
         X_ASSET_CATEGORY_ID,
         X_ROUNDING_FACTOR,
         X_UNIT_OF_ISSUE,
         X_ENFORCE_SHIP_TO_LOCATION_COD,
         X_ALLOW_SUBSTITUTE_RECEIPTS_FL,
         X_ALLOW_UNORDERED_RECEIPTS_FLA,
         X_ALLOW_EXPRESS_DELIVERY_FLAG,
         X_DAYS_EARLY_RECEIPT_ALLOWED,
         X_DAYS_LATE_RECEIPT_ALLOWED,
         X_RECEIPT_DAYS_EXCEPTION_CODE,
         X_RECEIVING_ROUTING_ID,
         X_INVOICE_CLOSE_TOLERANCE,
         X_RECEIVE_CLOSE_TOLERANCE,
         X_AUTO_LOT_ALPHA_PREFIX,
         X_START_AUTO_LOT_NUMBER,
         X_LOT_CONTROL_CODE,
         X_SHELF_LIFE_CODE,
         X_SHELF_LIFE_DAYS,
         X_SERIAL_NUMBER_CONTROL_CODE,
         X_START_AUTO_SERIAL_NUMBER,
         X_AUTO_SERIAL_ALPHA_PREFIX,
         X_SOURCE_TYPE,
         X_SOURCE_ORGANIZATION_ID,
         X_SOURCE_SUBINVENTORY,
         X_EXPENSE_ACCOUNT,
         X_ENCUMBRANCE_ACCOUNT,
         X_RESTRICT_SUBINVENTORIES_CODE,
         X_UNIT_WEIGHT,
         X_WEIGHT_UOM_CODE,
         X_VOLUME_UOM_CODE,
         X_UNIT_VOLUME,
         X_RESTRICT_LOCATORS_CODE,
         X_LOCATION_CONTROL_CODE,
         X_SHRINKAGE_RATE,
         X_ACCEPTABLE_EARLY_DAYS,
         X_PLANNING_TIME_FENCE_CODE,
         X_DEMAND_TIME_FENCE_CODE,
         X_LEAD_TIME_LOT_SIZE,
         X_STD_LOT_SIZE,
         X_CUM_MANUFACTURING_LEAD_TIME,
         X_OVERRUN_PERCENTAGE,
         X_MRP_CALCULATE_ATP_FLAG,
         X_ACCEPTABLE_RATE_INCREASE,
         X_ACCEPTABLE_RATE_DECREASE,
         X_CUMULATIVE_TOTAL_LEAD_TIME,
         X_PLANNING_TIME_FENCE_DAYS,
         X_DEMAND_TIME_FENCE_DAYS,
         X_END_ASSEMBLY_PEGGING_FLAG,
         X_REPETITIVE_PLANNING_FLAG,
         X_PLANNING_EXCEPTION_SET,
         X_BOM_ITEM_TYPE,
         X_PICK_COMPONENTS_FLAG,
         X_REPLENISH_TO_ORDER_FLAG,
         X_BASE_ITEM_ID,
         X_ATP_COMPONENTS_FLAG,
         X_ATP_FLAG,
         X_FIXED_LEAD_TIME,
         X_VARIABLE_LEAD_TIME,
         --X_WIP_SUPPLY_LOCATOR_ID, --Cannot be same for Source Org and Destination org hence should not be populated into IFACE
         X_WIP_SUPPLY_TYPE,
         --X_WIP_SUPPLY_SUBINVENTORY, --Cannot be same for Source Org and Destination org hence should not be populated into IFACE
         X_COST_OF_SALES_ACCOUNT,
         X_SALES_ACCOUNT,
         X_DEFAULT_INCLUDE_IN_ROLLUP_FL,
         X_INVENTORY_ITEM_STATUS_CODE,
         X_INVENTORY_PLANNING_CODE,
         L_PLANNER_CODE,--X_PLANNER_CODE,
         X_PLANNING_MAKE_BUY_CODE,
         X_FIXED_LOT_MULTIPLIER,
         X_ROUNDING_CONTROL_TYPE,
         X_CARRYING_COST,
         X_POSTPROCESSING_LEAD_TIME,
         X_PREPROCESSING_LEAD_TIME,
         X_BUYER_ID,
         X_ACCOUNTING_RULE_ID,
         X_INVOICING_RULE_ID,
         X_OVER_SHIPMENT_TOLERANCE,
         X_UNDER_SHIPMENT_TOLERANCE,
         X_OVER_RETURN_TOLERANCE,
         X_UNDER_RETURN_TOLERANCE,
         X_EQUIPMENT_TYPE,
         X_RECOVERED_PART_DISP_CODE,
         X_DEFECT_TRACKING_ON_FLAG,
         X_EVENT_FLAG,
         X_ELECTRONIC_FLAG,
         X_DOWNLOADABLE_FLAG,
         X_VOL_DISCOUNT_EXEMPT_FLAG,
         X_COUPON_EXEMPT_FLAG,
         X_COMMS_NL_TRACKABLE_FLAG,
         X_ASSET_CREATION_CODE,
         X_COMMS_ACTIVATION_REQD_FLAG,
         X_ORDERABLE_ON_WEB_FLAG,
         X_BACK_ORDERABLE_FLAG,
         X_WEB_STATUS,
         X_INDIVISIBLE_FLAG,
         X_DIMENSION_UOM_CODE,
         X_UNIT_LENGTH,
         X_UNIT_WIDTH,
         X_UNIT_HEIGHT,
         X_BULK_PICKED_FLAG,
         X_LOT_STATUS_ENABLED,
         X_DEFAULT_LOT_STATUS_ID,
         X_SERIAL_STATUS_ENABLED,
         X_DEFAULT_SERIAL_STATUS_ID,
         X_LOT_SPLIT_ENABLED,
         X_LOT_MERGE_ENABLED,
         X_INVENTORY_CARRY_PENALTY,
         X_OPERATION_SLACK_PENALTY,
         X_FINANCING_ALLOWED_FLAG,
         X_EAM_ITEM_TYPE,
         X_EAM_ACTIVITY_TYPE_CODE,
         X_EAM_ACTIVITY_CAUSE_CODE,
         X_EAM_ACT_NOTIFICATION_FLAG,
         X_EAM_ACT_SHUTDOWN_STATUS,
         X_DUAL_UOM_CONTROL,
         X_SECONDARY_UOM_CODE,
         X_DUAL_UOM_DEVIATION_HIGH,
         X_DUAL_UOM_DEVIATION_LOW
         /* -- DERIVED ATTRIBUTES
         ,
          L_SERVICE_ITEM_FLAG,
          L_VENDOR_WARRANTY_FLAG,
          L_USAGE_ITEM_FLAG
          --*/,
         X_CONTRACT_ITEM_TYPE_CODE,
         X_SUBSCRIPTION_DEPEND_FLAG,
         X_SERV_REQ_ENABLED_CODE,
         X_SERV_BILLING_ENABLED_FLAG,
         X_SERV_IMPORTANCE_LEVEL,
         X_PLANNED_INV_POINT_FLAG,
         X_LOT_TRANSLATE_ENABLED,
         X_DEFAULT_SO_SOURCE_TYPE,
         X_CREATE_SUPPLY_FLAG,
         X_SUBSTITUTION_WINDOW_CODE,
         X_SUBSTITUTION_WINDOW_DAYS,
         X_SEGMENT1,
         X_SEGMENT2,
         X_SEGMENT3,
         X_SEGMENT4,
         X_SEGMENT5,
         X_SEGMENT6,
         X_SEGMENT7,
         X_SEGMENT8,
         X_SEGMENT9,
         X_SEGMENT10,
         X_SEGMENT11,
         X_SEGMENT12,
         X_SEGMENT13,
         X_SEGMENT14,
         X_SEGMENT15,
         X_SEGMENT16,
         X_SEGMENT17,
         X_SEGMENT18,
         X_SEGMENT19,
         X_SEGMENT20,
         X_ATTRIBUTE_CATEGORY,
         X_ATTRIBUTE1,
         X_ATTRIBUTE2,
         X_ATTRIBUTE3,
         X_ATTRIBUTE4,
         X_ATTRIBUTE5,
         X_CREATION_DATE,
         X_CREATED_BY,
         X_LAST_UPDATE_DATE,
         X_LAST_UPDATED_BY,
         X_LAST_UPDATE_LOGIN,
         --X_PROGRAM_UPDATE_DATE ,
         --X_OBJECT_VERSION_NUMBER ,
         X_TRACKING_QUANTITY_IND,
         X_ONT_PRICING_QTY_SOURCE,
         X_CONSIGNED_FLAG,
         X_ASN_AUTOEXPIRE_FLAG,
         X_VMI_FORECAST_TYPE,
         X_EXCLUDE_FROM_BUDGET_FLAG,
         X_DRP_PLANNED_FLAG,
         X_CRITICAL_COMPONENT_FLAG,
         X_CONTINOUS_TRANSFER,
         X_CONVERGENCE,
         X_DIVERGENCE);
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        t_error_code    := SQLCODE;
        t_error_message := SQLERRM;
        --FOR NOW USING SEGMENT1, AS IT WOULD WORK FOR QUALCOMM,HOWEVER NEED TO MODIFY THE BELOW CODE AT A LATER POINT TO SUPPORT
        --INSTANCES WHERE MUTLIPLE SEGEMENTS WOULD BE USED FOR ITEM NUMBER
        INSERT INTO t_bom_copy_errors
        VALUES
          (X_BOM_COPY_ID,
           l_target_org_code,
           X_SEGMENT1,
           900,
           'E',
           'Errored while inserting into MTL_SYSTEM_ITEMS_INTERFACE:- ' ||
           t_error_code || '---' || t_error_message);
        commit;
        dbms_output.put_line('errored in item creation');
    END;
    --Inserting Revision Details into iface
    BEGIN
      /*
      Vishnu Vardhan Gutta, 01/08/2015.
      Copied the below SQL to get rev count from old code -- Need to understand why its being used in caliculating implimentation_date
      and effectivity_date, Since the bom_copy is working fine with below logic so for now not making any changes to it
      */
      select count(1)
        into t_rev_count
        from mtl_item_revisions
       where inventory_item_id = X_INVENTORY_ITEM_ID
         and organization_id = X_SRC_ORGANIZATION_ID;
      INSERT INTO mtl_item_revisions_interface
        (inventory_item_id,
         Revision,
         Revision_label,
         last_update_date,
         last_updated_by,
         creation_date,
         created_by,
         implementation_date,
         effectivity_date,
         organization_id,
         process_flag,
         transaction_type,
         set_process_id,
         ATTRIBUTE1,
         ATTRIBUTE2,
         ATTRIBUTE3,
         ATTRIBUTE4,
         ATTRIBUTE5,
         ATTRIBUTE6,
         ATTRIBUTE7,
         ATTRIBUTE8,
         ATTRIBUTE9,
         ATTRIBUTE10,
         ATTRIBUTE11,
         ATTRIBUTE12,
         ATTRIBUTE13,
         ATTRIBUTE14,
         ATTRIBUTE15)
        SELECT X_INVENTORY_ITEM_ID,
               mir.revision,
               mir.revision,
               sysdate,
               x_user_id,
               sysdate,
               x_user_id,
               sysdate +0.0001,--sysdate + (0.003472 * (1 + t_rev_count)), --implementation_date,
               sysdate +0.0001,--sysdate + (0.003472 * (1 + t_rev_count)), -- effectivity_date,
               X_ORGANIZATION_ID,
               1,
               'CREATE',
               l_set_prc_id,
               MIR.ATTRIBUTE1,
               MIR.ATTRIBUTE2,
               MIR.ATTRIBUTE3,
               MIR.ATTRIBUTE4,
               MIR.ATTRIBUTE5,
               MIR.ATTRIBUTE6,
               MIR.ATTRIBUTE7,
               MIR.ATTRIBUTE8,
               MIR.ATTRIBUTE9,
               MIR.ATTRIBUTE10,
               MIR.ATTRIBUTE11,
               MIR.ATTRIBUTE12,
               MIR.ATTRIBUTE13,
               MIR.ATTRIBUTE14,
               MIR.ATTRIBUTE15
          FROM mtl_item_revisions mir, mtl_parameters mp -- Added by Vishnu, On 17th Dec 2014, for getting the default revision
         WHERE mir.organization_id = X_SRC_ORGANIZATION_ID
           AND mir.inventory_item_id = X_INVENTORY_ITEM_ID
           and mir.organization_id = mp.organization_id
           and mir.revision <> mp.starting_revision
              --BELOW CONDITION IS TO GET THE LATEST REVISION  -- MASS BOM COPY SHOULD OLNY COPY THE LATEST REVISION(QUALCOMM CLIENT REQUIREMENT)
           AND mir.REVISION =
               (SELECT MAX(mir2.REVISION)
                  FROM mtl_item_revisions mir2
                 WHERE mir2.organization_id = X_SRC_ORGANIZATION_ID
                   AND mir2.inventory_item_id = X_INVENTORY_ITEM_ID);
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        t_error_code    := SQLCODE;
        t_error_message := SQLERRM;
        --FOR NOW USING SEGMENT1, AS IT WOULD WORK FOR QUALCOMM,HOWEVER NEED TO MODIFY THE BELOW CODE AT A LATER POINT TO SUPPORT
        --INSTANCES WHERE MUTLIPLE SEGEMENTS WOULD BE USED FOR ITEM NUMBER
        INSERT INTO t_bom_copy_errors
        VALUES
          (X_BOM_COPY_ID,
           l_target_org_code,
           X_SEGMENT1,
           901,
           'E',
           'Errored while inserting into MTL_ITEM_REVISIONS_INTERFACE:- ' ||
           t_error_code || '---' || t_error_message);
        commit;
        dbms_output.put_line('errored in item creation');
    END;
    --Inserting Category Details into iface
    BEGIN
      INSERT INTO MTL_ITEM_CATEGORIES_INTERFACE
        (inventory_item_id,
         category_set_id,
         category_id,
         last_update_date,
         last_updated_by,
         creation_date,
         created_by,
         last_update_login,
         organization_code,
         process_flag,
         transaction_type,
         set_process_id)
        SELECT inventory_item_id,
               category_set_id,
               category_id,
               trunc(sysdate),
               x_user_id,
               trunc(sysdate),
               x_user_id,
               x_user_id,
               l_target_org_code,
               1,
               'CREATE',
               l_set_prc_id
          FROM mtl_item_categories_v
         WHERE organization_id = X_SRC_ORGANIZATION_ID
           AND inventory_item_id = X_INVENTORY_ITEM_ID
           AND control_level = 2;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        t_error_code    := SQLCODE;
        t_error_message := SQLERRM;
        --FOR NOW USING SEGMENT1, AS IT WOULD WORK FOR QUALCOMM,HOWEVER NEED TO MODIFY THE BELOW CODE AT A LATER POINT TO SUPPORT
        --INSTANCES WHERE MUTLIPLE SEGEMENTS WOULD BE USED FOR ITEM NUMBER
        INSERT INTO t_bom_copy_errors
        VALUES
          (X_BOM_COPY_ID,
           l_target_org_code,
           X_SEGMENT1,
           902,
           'E',
           'Errored while inserting into MTL_ITEM_CATEGORIES_INTERFACE:- ' ||
           t_error_code || '---' || t_error_message);
        commit;
        dbms_output.put_line('errored in item creation');
    END;
    --Logging info
    /*t_COUNT := 0;
    SELECT COUNT(*)
      INTO t_COUNT
      FROM MTL_SYSTEM_ITEMS_INTERFACE
     WHERE TRUNC(CREATION_DATE) = TRUNC(SYSDATE)
       AND INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
       AND ORGANIZATION_ID = X_ORGANIZATION_ID
       AND SET_PROCESS_ID = l_set_prc_id;
    IF (t_COUNT > 0) THEN
      INSERT INTO mbc_temp
      VALUES
        (1.2,
         'INSERTED IN MSII FOR SET_PROCESS_ID:' || l_set_prc_id,
         SYSDATE);
      t_COUNT := 0;
    END IF;
    SELECT COUNT(*)
      INTO t_COUNT
      FROM MTL_ITEM_CATEGORIES_INTERFACE
     WHERE TRUNC(CREATION_DATE) = TRUNC(SYSDATE)
       AND INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
       AND ORGANIZATION_ID = X_ORGANIZATION_ID;
    IF (t_COUNT > 0) THEN
      INSERT INTO mbc_temp
      VALUES
        (1.3,
         'INSERTED IN MICI FOR SET_PROCESS_ID:' || l_set_prc_id,
         SYSDATE);
      t_COUNT := 0;
    END IF;
    SELECT COUNT(*)
      INTO t_COUNT
      FROM mtl_item_revisions_interface
     WHERE TRUNC(CREATION_DATE) = TRUNC(SYSDATE)
       AND INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
       AND ORGANIZATION_ID = X_ORGANIZATION_ID;
    IF (t_COUNT > 0) THEN
      INSERT INTO mbc_temp
      VALUES
        (1.4, 'COUNT OF RECORDS INSERTED IN MIRI:' || t_COUNT, SYSDATE);
      t_COUNT := 0;
    end if;
    COMMIT;*/
    --
    BEGIN
      L_RETURN_STATUS := INVPOPIF.inopinp_open_interface_process(X_ORGANIZATION_ID, -- org_id      NUMBER,
                                                                 1, -- all_org     NUMBER       := 1,
                                                                 1, -- val_item_flag  NUMBER    := 1,
                                                                 1, -- pro_item_flag  NUMBER    := 1,
                                                                 2, -- del_rec_flag      NUMBER := 1,Don't delete the records after successful processing
                                                                 NULL, -- prog_appid     NUMBER      := -1,
                                                                 NULL, -- prog_id     NUMBER      := -1,
                                                                 NULL, -- request_id     NUMBER      := -1,
                                                                 X_USER_ID, -- user_id     NUMBER      := -1,
                                                                 X_USER_ID, -- login_id    NUMBER      := -1,
                                                                 L_ERRBUF, -- err_text IN OUT   VARCHAR2,
                                                                 l_set_prc_id, -- xset_id  IN       NUMBER       DEFAULT -999,
                                                                 1, -- commit_flag IN       NUMBER       DEFAULT 1,
                                                                 1 -- run_mode   1 for insert and 2 for update
                                                                 );
      /*INSERT INTO mbc_temp
      VALUES
        (1.5, 'INSERT L_RETURN_STATUS:' || L_RETURN_STATUS, SYSDATE);*/
      COMMIT;
      IF (L_RETURN_STATUS = FND_API.G_RET_STS_ERROR) THEN
        /*INSERT INTO mbc_temp
        VALUES
          (1.6, 'INSERT L_RETURN_STATUS:' || L_MSG_DATA, SYSDATE);
        COMMIT;*/
        FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
        APP_EXCEPTION.RAISE_EXCEPTION;
        INSERT INTO t_bom_copy_errors
        VALUES
          (X_BOM_COPY_ID,
           l_target_org_code,
           X_SEGMENT1,
           903,
           'E',
           'Errored while invoking items API:- ' || L_MSG_DATA);
        commit;
      ELSIF (L_RETURN_STATUS = FND_API.G_RET_STS_UNEXP_ERROR) THEN
        /*INSERT INTO mbc_temp
        VALUES
          (1.7, 'INSERT L_RETURN_STATUS:' || L_MSG_DATA, SYSDATE);
        COMMIT;*/
        FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
        APP_EXCEPTION.RAISE_EXCEPTION;
        INSERT INTO t_bom_copy_errors
        VALUES
          (X_BOM_COPY_ID,
           l_target_org_code,
           X_SEGMENT1,
           904,
           'E',
           'Errored while invoking items API:- ' || L_MSG_DATA);
        commit;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        t_error_code    := SQLCODE;
        t_error_message := SQLERRM;
        /*INSERT INTO mbc_temp
        VALUES
          (1.8, 'INSERT SQLCODE:' || t_error_code, SYSDATE);
        INSERT INTO mbc_temp
        VALUES
          (1.9, 'INSERT SQLERRM ' || t_error_message, SYSDATE);
        COMMIT;*/
        dbms_output.put_line('errored in item creation');
    END;
  END INSERT_ROW;
/*    All of below code commented by Vishnu on 01/07/2015
      The below code is old implimentation for MBC.
      In new implimentation above instead of base table updates we are now using iface's and API's
*/
/* IF (X_ORGANIZATION_ID = GET_MASTER_ORG_ID(X_ORGANIZATION_ID)) THEN
      -- IF THE ORG IS MASTER, INSERT THE SOURCE LANGUAGE TRANSLATED COLUMNS
      -- FOR CHILD ORGANIZATIONS.
      INSERT INTO MTL_SYSTEM_ITEMS_TL
        (INVENTORY_ITEM_ID,
         ORGANIZATION_ID,
         LANGUAGE,
         SOURCE_LANG,
         DESCRIPTION,
         LONG_DESCRIPTION,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         CREATION_DATE,
         CREATED_BY,
         LAST_UPDATE_LOGIN)
        SELECT X_INVENTORY_ITEM_ID,
               X_ORGANIZATION_ID,
               L.LANGUAGE_CODE,
               USERENV('LANG'),
               X_DESCRIPTION,
               X_LONG_DESCRIPTION,
               X_LAST_UPDATE_DATE,
               X_LAST_UPDATED_BY,
               X_CREATION_DATE,
               X_CREATED_BY,
               X_LAST_UPDATE_LOGIN
          FROM FND_LANGUAGES L
         WHERE L.INSTALLED_FLAG IN ('I', 'B')
           AND NOT EXISTS
         (SELECT NULL
                  FROM MTL_SYSTEM_ITEMS_TL T
                 WHERE T.INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
                   AND T.ORGANIZATION_ID = X_ORGANIZATION_ID
                   AND T.LANGUAGE = L.LANGUAGE_CODE);
    ELSE
      -- IF THE ORG IS NOT MASTER, THEN WHILE CREATING NEW CHILD ITEMS,
      -- COPY TRANSLATED COLUMNS FROM THE MASTER ITEM RECORD.
      INSERT INTO MTL_SYSTEM_ITEMS_TL
        (INVENTORY_ITEM_ID,
         ORGANIZATION_ID,
         LANGUAGE,
         SOURCE_LANG,
         DESCRIPTION,
         LONG_DESCRIPTION,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         CREATION_DATE,
         CREATED_BY,
         LAST_UPDATE_LOGIN)
        SELECT X_INVENTORY_ITEM_ID,
               X_ORGANIZATION_ID,
               MSI.LANGUAGE,
               MSI.SOURCE_LANG,
               MSI.DESCRIPTION,
               MSI.LONG_DESCRIPTION,
               X_LAST_UPDATE_DATE,
               X_LAST_UPDATED_BY,
               X_CREATION_DATE,
               X_CREATED_BY,
               X_LAST_UPDATE_LOGIN
          FROM MTL_SYSTEM_ITEMS_TL MSI, MTL_PARAMETERS MP
         WHERE MSI.INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
           AND MSI.ORGANIZATION_ID = MP.MASTER_ORGANIZATION_ID
           AND MP.ORGANIZATION_ID = X_ORGANIZATION_ID;
    END IF;
    OPEN C;
    FETCH C
      INTO X_ROWID;
    IF (C%NOTFOUND) THEN
      CLOSE C;
      RAISE NO_DATA_FOUND;
    END IF;
    CLOSE C;*/
/* --
    -- FINALLY, SEND MESSAGES TO DEPENDENT BUSINESS OBJECTS.
    --
    ENI_ITEMS_STAR_PKG.INSERT_ITEMS_IN_STAR(P_API_VERSION       => 1.0,
                                            P_INIT_MSG_LIST     => FND_API.G_TRUE,
                                            P_INVENTORY_ITEM_ID => L_INVENTORY_ITEM_ID,
                                            P_ORGANIZATION_ID   => L_ORGANIZATION_ID,
                                            X_RETURN_STATUS     => L_RETURN_STATUS,
                                            X_MSG_COUNT         => L_MSG_COUNT,
                                            X_MSG_DATA          => L_MSG_DATA);
    IF (L_RETURN_STATUS = FND_API.G_RET_STS_ERROR) THEN
      FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
      APP_EXCEPTION.RAISE_EXCEPTION;
    ELSIF (L_RETURN_STATUS = FND_API.G_RET_STS_UNEXP_ERROR) THEN
      FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
  END INSERT_ROW;*/
/*  -- ------------------ LOCK_ROW -------------------
  PROCEDURE LOCK_ROW(X_INVENTORY_ITEM_ID IN NUMBER,
                     X_ORGANIZATION_ID   IN NUMBER,
                     --  X_MASTER_ORG_ID   IN NUMBER,
                     X_DESCRIPTION      IN VARCHAR2,
                     X_LONG_DESCRIPTION IN VARCHAR2,
                     X_PRIMARY_UOM_CODE IN VARCHAR2,
                     --  X_PRIMARY_UNIT_OF_MEASURE IN VARCHAR2,
                     X_ALLOWED_UNITS_LOOKUP_CODE    IN NUMBER,
                     X_OVERCOMPLETION_TOLERANCE_TYP IN NUMBER,
                     X_OVERCOMPLETION_TOLERANCE_VAL IN NUMBER,
                     X_EFFECTIVITY_CONTROL          IN NUMBER,
                     X_CHECK_SHORTAGES_FLAG         IN VARCHAR2,
                     X_FULL_LEAD_TIME               IN NUMBER,
                     X_ORDER_COST                   IN NUMBER,
                     X_MRP_SAFETY_STOCK_PERCENT     IN NUMBER,
                     X_MRP_SAFETY_STOCK_CODE        IN NUMBER,
                     X_MIN_MINMAX_QUANTITY          IN NUMBER,
                     X_MAX_MINMAX_QUANTITY          IN NUMBER,
                     X_MINIMUM_ORDER_QUANTITY       IN NUMBER,
                     X_FIXED_ORDER_QUANTITY         IN NUMBER,
                     X_FIXED_DAYS_SUPPLY            IN NUMBER,
                     X_MAXIMUM_ORDER_QUANTITY       IN NUMBER,
                     X_ATP_RULE_ID                  IN NUMBER,
                     X_PICKING_RULE_ID              IN NUMBER,
                     X_RESERVABLE_TYPE              IN NUMBER,
                     X_POSITIVE_MEASUREMENT_ERROR   IN NUMBER,
                     X_NEGATIVE_MEASUREMENT_ERROR   IN NUMBER,
                     X_ENGINEERING_ECN_CODE         IN VARCHAR2,
                     X_ENGINEERING_ITEM_ID          IN NUMBER,
                     X_ENGINEERING_DATE             IN DATE,
                     X_SERVICE_STARTING_DELAY       IN NUMBER,
                     X_SERVICEABLE_COMPONENT_FLAG   IN VARCHAR2,
                     X_SERVICEABLE_PRODUCT_FLAG     IN VARCHAR2,
                     --  X_BASE_WARRANTY_SERVICE_ID IN NUMBER,
                     X_PAYMENT_TERMS_ID            IN NUMBER,
                     X_PREVENTIVE_MAINTENANCE_FLAG IN VARCHAR2,
                     --  X_PRIMARY_SPECIALIST_ID IN NUMBER,
                     --  X_SECONDARY_SPECIALIST_ID IN NUMBER,
                     --  X_SERVICEABLE_ITEM_CLASS_ID IN NUMBER,
                     --  X_TIME_BILLABLE_FLAG IN VARCHAR2,
                     X_MATERIAL_BILLABLE_FLAG IN VARCHAR2,
                     --  X_EXPENSE_BILLABLE_FLAG IN VARCHAR2,
                     X_PRORATE_SERVICE_FLAG         IN VARCHAR2,
                     X_COVERAGE_SCHEDULE_ID         IN NUMBER,
                     X_SERVICE_DURATION_PERIOD_CODE IN VARCHAR2,
                     X_SERVICE_DURATION             IN NUMBER,
                     --  X_WARRANTY_VENDOR_ID IN NUMBER,
                     --  X_MAX_WARRANTY_AMOUNT IN NUMBER,
                     --  X_RESPONSE_TIME_PERIOD_CODE IN VARCHAR2,
                     --  X_RESPONSE_TIME_VALUE IN NUMBER,
                     --  X_NEW_REVISION_CODE IN VARCHAR2,
                     X_INVOICEABLE_ITEM_FLAG        IN VARCHAR2,
                     X_TAX_CODE                     IN VARCHAR2,
                     X_INVOICE_ENABLED_FLAG         IN VARCHAR2,
                     X_MUST_USE_APPROVED_VENDOR_FLA IN VARCHAR2,
                     --  X_REQUEST_ID IN NUMBER,
                     X_OUTSIDE_OPERATION_FLAG       IN VARCHAR2,
                     X_OUTSIDE_OPERATION_UOM_TYPE   IN VARCHAR2,
                     X_SAFETY_STOCK_BUCKET_DAYS     IN NUMBER,
                     X_AUTO_REDUCE_MPS              IN NUMBER,
                     X_COSTING_ENABLED_FLAG         IN VARCHAR2,
                     X_AUTO_CREATED_CONFIG_FLAG     IN VARCHAR2,
                     X_CYCLE_COUNT_ENABLED_FLAG     IN VARCHAR2,
                     X_ITEM_TYPE                    IN VARCHAR2,
                     X_MODEL_CONFIG_CLAUSE_NAME     IN VARCHAR2,
                     X_SHIP_MODEL_COMPLETE_FLAG     IN VARCHAR2,
                     X_MRP_PLANNING_CODE            IN NUMBER,
                     X_RETURN_INSPECTION_REQUIREMEN IN NUMBER,
                     X_ATO_FORECAST_CONTROL         IN NUMBER,
                     X_RELEASE_TIME_FENCE_CODE      IN NUMBER,
                     X_RELEASE_TIME_FENCE_DAYS      IN NUMBER,
                     X_CONTAINER_ITEM_FLAG          IN VARCHAR2,
                     X_VEHICLE_ITEM_FLAG            IN VARCHAR2,
                     X_MAXIMUM_LOAD_WEIGHT          IN NUMBER,
                     X_MINIMUM_FILL_PERCENT         IN NUMBER,
                     X_CONTAINER_TYPE_CODE          IN VARCHAR2,
                     X_INTERNAL_VOLUME              IN NUMBER,
                     --  X_WH_UPDATE_DATE IN DATE,
                     X_PRODUCT_FAMILY_ITEM_ID       IN NUMBER,
                     X_GLOBAL_ATTRIBUTE_CATEGORY    IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE1            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE2            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE3            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE4            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE5            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE6            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE7            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE8            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE9            IN VARCHAR2,
                     X_GLOBAL_ATTRIBUTE10           IN VARCHAR2,
                     X_PURCHASING_TAX_CODE          IN VARCHAR2,
                     X_ATTRIBUTE6                   IN VARCHAR2,
                     X_ATTRIBUTE7                   IN VARCHAR2,
                     X_ATTRIBUTE8                   IN VARCHAR2,
                     X_ATTRIBUTE9                   IN VARCHAR2,
                     X_ATTRIBUTE10                  IN VARCHAR2,
                     X_ATTRIBUTE11                  IN VARCHAR2,
                     X_ATTRIBUTE12                  IN VARCHAR2,
                     X_ATTRIBUTE13                  IN VARCHAR2,
                     X_ATTRIBUTE14                  IN VARCHAR2,
                     X_ATTRIBUTE15                  IN VARCHAR2,
                     X_PURCHASING_ITEM_FLAG         IN VARCHAR2,
                     X_SHIPPABLE_ITEM_FLAG          IN VARCHAR2,
                     X_CUSTOMER_ORDER_FLAG          IN VARCHAR2,
                     X_INTERNAL_ORDER_FLAG          IN VARCHAR2,
                     X_INVENTORY_ITEM_FLAG          IN VARCHAR2,
                     X_ENG_ITEM_FLAG                IN VARCHAR2,
                     X_INVENTORY_ASSET_FLAG         IN VARCHAR2,
                     X_PURCHASING_ENABLED_FLAG      IN VARCHAR2,
                     X_CUSTOMER_ORDER_ENABLED_FLAG  IN VARCHAR2,
                     X_INTERNAL_ORDER_ENABLED_FLAG  IN VARCHAR2,
                     X_SO_TRANSACTIONS_FLAG         IN VARCHAR2,
                     X_MTL_TRANSACTIONS_ENABLED_FLA IN VARCHAR2,
                     X_STOCK_ENABLED_FLAG           IN VARCHAR2,
                     X_BOM_ENABLED_FLAG             IN VARCHAR2,
                     X_BUILD_IN_WIP_FLAG            IN VARCHAR2,
                     X_REVISION_QTY_CONTROL_CODE    IN NUMBER,
                     X_ITEM_CATALOG_GROUP_ID        IN NUMBER,
                     X_CATALOG_STATUS_FLAG          IN VARCHAR2,
                     X_RETURNABLE_FLAG              IN VARCHAR2,
                     X_DEFAULT_SHIPPING_ORG         IN NUMBER,
                     X_COLLATERAL_FLAG              IN VARCHAR2,
                     X_TAXABLE_FLAG                 IN VARCHAR2,
                     X_QTY_RCV_EXCEPTION_CODE       IN VARCHAR2,
                     X_ALLOW_ITEM_DESC_UPDATE_FLAG  IN VARCHAR2,
                     X_INSPECTION_REQUIRED_FLAG     IN VARCHAR2,
                     X_RECEIPT_REQUIRED_FLAG        IN VARCHAR2,
                     X_MARKET_PRICE                 IN NUMBER,
                     X_HAZARD_CLASS_ID              IN NUMBER,
                     X_RFQ_REQUIRED_FLAG            IN VARCHAR2,
                     X_QTY_RCV_TOLERANCE            IN NUMBER,
                     X_LIST_PRICE_PER_UNIT          IN NUMBER,
                     X_UN_NUMBER_ID                 IN NUMBER,
                     X_PRICE_TOLERANCE_PERCENT      IN NUMBER,
                     X_ASSET_CATEGORY_ID            IN NUMBER,
                     X_ROUNDING_FACTOR              IN NUMBER,
                     X_UNIT_OF_ISSUE                IN VARCHAR2,
                     X_ENFORCE_SHIP_TO_LOCATION_COD IN VARCHAR2,
                     X_ALLOW_SUBSTITUTE_RECEIPTS_FL IN VARCHAR2,
                     X_ALLOW_UNORDERED_RECEIPTS_FLA IN VARCHAR2,
                     X_ALLOW_EXPRESS_DELIVERY_FLAG  IN VARCHAR2,
                     X_DAYS_EARLY_RECEIPT_ALLOWED   IN NUMBER,
                     X_DAYS_LATE_RECEIPT_ALLOWED    IN NUMBER,
                     X_RECEIPT_DAYS_EXCEPTION_CODE  IN VARCHAR2,
                     X_RECEIVING_ROUTING_ID         IN NUMBER,
                     X_INVOICE_CLOSE_TOLERANCE      IN NUMBER,
                     X_RECEIVE_CLOSE_TOLERANCE      IN NUMBER,
                     X_AUTO_LOT_ALPHA_PREFIX        IN VARCHAR2,
                     X_START_AUTO_LOT_NUMBER        IN VARCHAR2,
                     X_LOT_CONTROL_CODE             IN NUMBER,
                     X_SHELF_LIFE_CODE              IN NUMBER,
                     X_SHELF_LIFE_DAYS              IN NUMBER,
                     X_SERIAL_NUMBER_CONTROL_CODE   IN NUMBER,
                     X_START_AUTO_SERIAL_NUMBER     IN VARCHAR2,
                     X_AUTO_SERIAL_ALPHA_PREFIX     IN VARCHAR2,
                     X_SOURCE_TYPE                  IN NUMBER,
                     X_SOURCE_ORGANIZATION_ID       IN NUMBER,
                     X_SOURCE_SUBINVENTORY          IN VARCHAR2,
                     X_EXPENSE_ACCOUNT              IN NUMBER,
                     X_ENCUMBRANCE_ACCOUNT          IN NUMBER,
                     X_RESTRICT_SUBINVENTORIES_CODE IN NUMBER,
                     X_UNIT_WEIGHT                  IN NUMBER,
                     X_WEIGHT_UOM_CODE              IN VARCHAR2,
                     X_VOLUME_UOM_CODE              IN VARCHAR2,
                     X_UNIT_VOLUME                  IN NUMBER,
                     X_RESTRICT_LOCATORS_CODE       IN NUMBER,
                     X_LOCATION_CONTROL_CODE        IN NUMBER,
                     X_SHRINKAGE_RATE               IN NUMBER,
                     X_ACCEPTABLE_EARLY_DAYS        IN NUMBER,
                     X_PLANNING_TIME_FENCE_CODE     IN NUMBER,
                     X_DEMAND_TIME_FENCE_CODE       IN NUMBER,
                     X_LEAD_TIME_LOT_SIZE           IN NUMBER,
                     X_STD_LOT_SIZE                 IN NUMBER,
                     X_CUM_MANUFACTURING_LEAD_TIME  IN NUMBER,
                     X_OVERRUN_PERCENTAGE           IN NUMBER,
                     X_MRP_CALCULATE_ATP_FLAG       IN VARCHAR2,
                     X_ACCEPTABLE_RATE_INCREASE     IN NUMBER,
                     X_ACCEPTABLE_RATE_DECREASE     IN NUMBER,
                     X_CUMULATIVE_TOTAL_LEAD_TIME   IN NUMBER,
                     X_PLANNING_TIME_FENCE_DAYS     IN NUMBER,
                     X_DEMAND_TIME_FENCE_DAYS       IN NUMBER,
                     X_END_ASSEMBLY_PEGGING_FLAG    IN VARCHAR2,
                     X_REPETITIVE_PLANNING_FLAG     IN VARCHAR2,
                     X_PLANNING_EXCEPTION_SET       IN VARCHAR2,
                     X_BOM_ITEM_TYPE                IN NUMBER,
                     X_PICK_COMPONENTS_FLAG         IN VARCHAR2,
                     X_REPLENISH_TO_ORDER_FLAG      IN VARCHAR2,
                     X_BASE_ITEM_ID                 IN NUMBER,
                     X_ATP_COMPONENTS_FLAG          IN VARCHAR2,
                     X_ATP_FLAG                     IN VARCHAR2,
                     X_FIXED_LEAD_TIME              IN NUMBER,
                     X_VARIABLE_LEAD_TIME           IN NUMBER,
                     X_WIP_SUPPLY_LOCATOR_ID        IN NUMBER,
                     X_WIP_SUPPLY_TYPE              IN NUMBER,
                     X_WIP_SUPPLY_SUBINVENTORY      IN VARCHAR2,
                     X_COST_OF_SALES_ACCOUNT        IN NUMBER,
                     X_SALES_ACCOUNT                IN NUMBER,
                     X_DEFAULT_INCLUDE_IN_ROLLUP_FL IN VARCHAR2,
                     X_INVENTORY_ITEM_STATUS_CODE   IN VARCHAR2,
                     X_INVENTORY_PLANNING_CODE      IN NUMBER,
                     X_PLANNER_CODE                 IN VARCHAR2,
                     X_PLANNING_MAKE_BUY_CODE       IN NUMBER,
                     X_FIXED_LOT_MULTIPLIER         IN NUMBER,
                     X_ROUNDING_CONTROL_TYPE        IN NUMBER,
                     X_CARRYING_COST                IN NUMBER,
                     X_POSTPROCESSING_LEAD_TIME     IN NUMBER,
                     X_PREPROCESSING_LEAD_TIME      IN NUMBER,
                     X_SUMMARY_FLAG                 IN VARCHAR2,
                     X_ENABLED_FLAG                 IN VARCHAR2,
                     X_START_DATE_ACTIVE            IN DATE,
                     X_END_DATE_ACTIVE              IN DATE,
                     X_BUYER_ID                     IN NUMBER,
                     X_ACCOUNTING_RULE_ID           IN NUMBER,
                     X_INVOICING_RULE_ID            IN NUMBER,
                     X_OVER_SHIPMENT_TOLERANCE      IN NUMBER,
                     X_UNDER_SHIPMENT_TOLERANCE     IN NUMBER,
                     X_OVER_RETURN_TOLERANCE        IN NUMBER,
                     X_UNDER_RETURN_TOLERANCE       IN NUMBER,
                     X_EQUIPMENT_TYPE               IN NUMBER,
                     X_RECOVERED_PART_DISP_CODE     IN VARCHAR2,
                     X_DEFECT_TRACKING_ON_FLAG      IN VARCHAR2,
                     X_EVENT_FLAG                   IN VARCHAR2,
                     X_ELECTRONIC_FLAG              IN VARCHAR2,
                     X_DOWNLOADABLE_FLAG            IN VARCHAR2,
                     X_VOL_DISCOUNT_EXEMPT_FLAG     IN VARCHAR2,
                     X_COUPON_EXEMPT_FLAG           IN VARCHAR2,
                     X_COMMS_NL_TRACKABLE_FLAG      IN VARCHAR2,
                     X_ASSET_CREATION_CODE          IN VARCHAR2,
                     X_COMMS_ACTIVATION_REQD_FLAG   IN VARCHAR2,
                     X_ORDERABLE_ON_WEB_FLAG        IN VARCHAR2,
                     X_BACK_ORDERABLE_FLAG          IN VARCHAR2,
                     X_WEB_STATUS                   IN VARCHAR2,
                     X_INDIVISIBLE_FLAG             IN VARCHAR2,
                     X_DIMENSION_UOM_CODE           IN VARCHAR2,
                     X_UNIT_LENGTH                  IN NUMBER,
                     X_UNIT_WIDTH                   IN NUMBER,
                     X_UNIT_HEIGHT                  IN NUMBER,
                     X_BULK_PICKED_FLAG             IN VARCHAR2,
                     X_LOT_STATUS_ENABLED           IN VARCHAR2,
                     X_DEFAULT_LOT_STATUS_ID        IN NUMBER,
                     X_SERIAL_STATUS_ENABLED        IN VARCHAR2,
                     X_DEFAULT_SERIAL_STATUS_ID     IN NUMBER,
                     X_LOT_SPLIT_ENABLED            IN VARCHAR2,
                     X_LOT_MERGE_ENABLED            IN VARCHAR2,
                     X_INVENTORY_CARRY_PENALTY      IN NUMBER,
                     X_OPERATION_SLACK_PENALTY      IN NUMBER,
                     X_FINANCING_ALLOWED_FLAG       IN VARCHAR2,
                     X_EAM_ITEM_TYPE                IN NUMBER,
                     X_EAM_ACTIVITY_TYPE_CODE       IN VARCHAR2,
                     X_EAM_ACTIVITY_CAUSE_CODE      IN VARCHAR2,
                     X_EAM_ACT_NOTIFICATION_FLAG    IN VARCHAR2,
                     X_EAM_ACT_SHUTDOWN_STATUS      IN VARCHAR2,
                     X_DUAL_UOM_CONTROL             IN NUMBER,
                     X_SECONDARY_UOM_CODE           IN VARCHAR2,
                     X_DUAL_UOM_DEVIATION_HIGH      IN NUMBER,
                     X_DUAL_UOM_DEVIATION_LOW       IN NUMBER
                     --,  X_SERVICE_ITEM_FLAG          IN   VARCHAR2
                     --,  X_VENDOR_WARRANTY_FLAG       IN   VARCHAR2
                     --,  X_USAGE_ITEM_FLAG            IN   VARCHAR2
                    ,
                     X_CONTRACT_ITEM_TYPE_CODE   IN VARCHAR2,
                     X_SUBSCRIPTION_DEPEND_FLAG  IN VARCHAR2,
                     X_SERV_REQ_ENABLED_CODE     IN VARCHAR2,
                     X_SERV_BILLING_ENABLED_FLAG IN VARCHAR2,
                     X_SERV_IMPORTANCE_LEVEL     IN NUMBER,
                     X_PLANNED_INV_POINT_FLAG    IN VARCHAR2,
                     X_LOT_TRANSLATE_ENABLED     IN VARCHAR2,
                     X_DEFAULT_SO_SOURCE_TYPE    IN VARCHAR2,
                     X_CREATE_SUPPLY_FLAG        IN VARCHAR2,
                     X_SUBSTITUTION_WINDOW_CODE  IN NUMBER,
                     X_SUBSTITUTION_WINDOW_DAYS  IN NUMBER,
                     X_SEGMENT1                  IN VARCHAR2,
                     X_SEGMENT2                  IN VARCHAR2,
                     X_SEGMENT3                  IN VARCHAR2,
                     X_SEGMENT4                  IN VARCHAR2,
                     X_SEGMENT5                  IN VARCHAR2,
                     X_SEGMENT6                  IN VARCHAR2,
                     X_SEGMENT7                  IN VARCHAR2,
                     X_SEGMENT8                  IN VARCHAR2,
                     X_SEGMENT9                  IN VARCHAR2,
                     X_SEGMENT10                 IN VARCHAR2,
                     X_SEGMENT11                 IN VARCHAR2,
                     X_SEGMENT12                 IN VARCHAR2,
                     X_SEGMENT13                 IN VARCHAR2,
                     X_SEGMENT14                 IN VARCHAR2,
                     X_SEGMENT15                 IN VARCHAR2,
                     X_SEGMENT16                 IN VARCHAR2,
                     X_SEGMENT17                 IN VARCHAR2,
                     X_SEGMENT18                 IN VARCHAR2,
                     X_SEGMENT19                 IN VARCHAR2,
                     X_SEGMENT20                 IN VARCHAR2,
                     X_ATTRIBUTE_CATEGORY        IN VARCHAR2,
                     X_ATTRIBUTE1                IN VARCHAR2,
                     X_ATTRIBUTE2                IN VARCHAR2,
                     X_ATTRIBUTE3                IN VARCHAR2,
                     X_ATTRIBUTE4                IN VARCHAR2,
                     X_ATTRIBUTE5                IN VARCHAR2,
                     -- X_PROGRAM_UPDATE_DATE IN DATE,
                     --X_OBJECT_VERSION_NUMBER IN NUMBER,
                     X_TRACKING_QUANTITY_IND    IN VARCHAR2,
                     X_ONT_PRICING_QTY_SOURCE   IN VARCHAR2,
                     X_CONSIGNED_FLAG           IN NUMBER,
                     X_ASN_AUTOEXPIRE_FLAG      IN NUMBER,
                     X_VMI_FORECAST_TYPE        IN NUMBER,
                     X_EXCLUDE_FROM_BUDGET_FLAG IN NUMBER,
                     X_DRP_PLANNED_FLAG         IN NUMBER,
                     X_CRITICAL_COMPONENT_FLAG  IN NUMBER,
                     X_CONTINOUS_TRANSFER       IN NUMBER,
                     X_CONVERGENCE              IN NUMBER,
                     X_DIVERGENCE               IN NUMBER) IS
    CURSOR I_CSR IS
      SELECT
      --  DESCRIPTION,
       PRIMARY_UOM_CODE,
       --  PRIMARY_UNIT_OF_MEASURE,
       ALLOWED_UNITS_LOOKUP_CODE,
       OVERCOMPLETION_TOLERANCE_TYPE,
       OVERCOMPLETION_TOLERANCE_VALUE,
       EFFECTIVITY_CONTROL,
       CHECK_SHORTAGES_FLAG,
       FULL_LEAD_TIME,
       ORDER_COST,
       MRP_SAFETY_STOCK_PERCENT,
       MRP_SAFETY_STOCK_CODE,
       MIN_MINMAX_QUANTITY,
       MAX_MINMAX_QUANTITY,
       MINIMUM_ORDER_QUANTITY,
       FIXED_ORDER_QUANTITY,
       FIXED_DAYS_SUPPLY,
       MAXIMUM_ORDER_QUANTITY,
       ATP_RULE_ID,
       PICKING_RULE_ID,
       RESERVABLE_TYPE,
       POSITIVE_MEASUREMENT_ERROR,
       NEGATIVE_MEASUREMENT_ERROR,
       ENGINEERING_ECN_CODE,
       ENGINEERING_ITEM_ID,
       ENGINEERING_DATE,
       SERVICE_STARTING_DELAY,
       SERVICEABLE_COMPONENT_FLAG,
       SERVICEABLE_PRODUCT_FLAG,
       --      BASE_WARRANTY_SERVICE_ID,
       PAYMENT_TERMS_ID,
       PREVENTIVE_MAINTENANCE_FLAG,
       --      PRIMARY_SPECIALIST_ID,
       --      SECONDARY_SPECIALIST_ID,
       --      SERVICEABLE_ITEM_CLASS_ID,
       --      TIME_BILLABLE_FLAG,
       MATERIAL_BILLABLE_FLAG,
       --      EXPENSE_BILLABLE_FLAG,
       PRORATE_SERVICE_FLAG,
       COVERAGE_SCHEDULE_ID,
       SERVICE_DURATION_PERIOD_CODE,
       SERVICE_DURATION,
       --      WARRANTY_VENDOR_ID,
       --      MAX_WARRANTY_AMOUNT,
       --      RESPONSE_TIME_PERIOD_CODE,
       --      RESPONSE_TIME_VALUE,
       --      NEW_REVISION_CODE,
       INVOICEABLE_ITEM_FLAG,
       TAX_CODE,
       INVOICE_ENABLED_FLAG,
       MUST_USE_APPROVED_VENDOR_FLAG,
       --      REQUEST_ID,
       OUTSIDE_OPERATION_FLAG,
       OUTSIDE_OPERATION_UOM_TYPE,
       SAFETY_STOCK_BUCKET_DAYS,
       AUTO_REDUCE_MPS,
       COSTING_ENABLED_FLAG,
       AUTO_CREATED_CONFIG_FLAG,
       CYCLE_COUNT_ENABLED_FLAG,
       ITEM_TYPE,
       MODEL_CONFIG_CLAUSE_NAME,
       SHIP_MODEL_COMPLETE_FLAG,
       MRP_PLANNING_CODE,
       RETURN_INSPECTION_REQUIREMENT,
       ATO_FORECAST_CONTROL,
       RELEASE_TIME_FENCE_CODE,
       RELEASE_TIME_FENCE_DAYS,
       CONTAINER_ITEM_FLAG,
       VEHICLE_ITEM_FLAG,
       MAXIMUM_LOAD_WEIGHT,
       MINIMUM_FILL_PERCENT,
       CONTAINER_TYPE_CODE,
       INTERNAL_VOLUME,
       --      WH_UPDATE_DATE,
       PRODUCT_FAMILY_ITEM_ID,
       GLOBAL_ATTRIBUTE_CATEGORY,
       GLOBAL_ATTRIBUTE1,
       GLOBAL_ATTRIBUTE2,
       GLOBAL_ATTRIBUTE3,
       GLOBAL_ATTRIBUTE4,
       GLOBAL_ATTRIBUTE5,
       GLOBAL_ATTRIBUTE6,
       GLOBAL_ATTRIBUTE7,
       GLOBAL_ATTRIBUTE8,
       GLOBAL_ATTRIBUTE9,
       GLOBAL_ATTRIBUTE10,
       PURCHASING_TAX_CODE,
       ATTRIBUTE6,
       ATTRIBUTE7,
       ATTRIBUTE8,
       ATTRIBUTE9,
       ATTRIBUTE10,
       ATTRIBUTE11,
       ATTRIBUTE12,
       ATTRIBUTE13,
       ATTRIBUTE14,
       ATTRIBUTE15,
       PURCHASING_ITEM_FLAG,
       SHIPPABLE_ITEM_FLAG,
       CUSTOMER_ORDER_FLAG,
       INTERNAL_ORDER_FLAG,
       INVENTORY_ITEM_FLAG,
       ENG_ITEM_FLAG,
       INVENTORY_ASSET_FLAG,
       PURCHASING_ENABLED_FLAG,
       CUSTOMER_ORDER_ENABLED_FLAG,
       INTERNAL_ORDER_ENABLED_FLAG,
       SO_TRANSACTIONS_FLAG,
       MTL_TRANSACTIONS_ENABLED_FLAG,
       STOCK_ENABLED_FLAG,
       BOM_ENABLED_FLAG,
       BUILD_IN_WIP_FLAG,
       REVISION_QTY_CONTROL_CODE,
       ITEM_CATALOG_GROUP_ID,
       CATALOG_STATUS_FLAG,
       RETURNABLE_FLAG,
       DEFAULT_SHIPPING_ORG,
       COLLATERAL_FLAG,
       TAXABLE_FLAG,
       QTY_RCV_EXCEPTION_CODE,
       ALLOW_ITEM_DESC_UPDATE_FLAG,
       INSPECTION_REQUIRED_FLAG,
       RECEIPT_REQUIRED_FLAG,
       MARKET_PRICE,
       HAZARD_CLASS_ID,
       RFQ_REQUIRED_FLAG,
       QTY_RCV_TOLERANCE,
       LIST_PRICE_PER_UNIT,
       UN_NUMBER_ID,
       PRICE_TOLERANCE_PERCENT,
       ASSET_CATEGORY_ID,
       ROUNDING_FACTOR,
       UNIT_OF_ISSUE,
       ENFORCE_SHIP_TO_LOCATION_CODE,
       ALLOW_SUBSTITUTE_RECEIPTS_FLAG,
       ALLOW_UNORDERED_RECEIPTS_FLAG,
       ALLOW_EXPRESS_DELIVERY_FLAG,
       DAYS_EARLY_RECEIPT_ALLOWED,
       DAYS_LATE_RECEIPT_ALLOWED,
       RECEIPT_DAYS_EXCEPTION_CODE,
       RECEIVING_ROUTING_ID,
       INVOICE_CLOSE_TOLERANCE,
       RECEIVE_CLOSE_TOLERANCE,
       AUTO_LOT_ALPHA_PREFIX,
       START_AUTO_LOT_NUMBER,
       LOT_CONTROL_CODE,
       SHELF_LIFE_CODE,
       SHELF_LIFE_DAYS,
       SERIAL_NUMBER_CONTROL_CODE,
       START_AUTO_SERIAL_NUMBER,
       AUTO_SERIAL_ALPHA_PREFIX,
       SOURCE_TYPE,
       SOURCE_ORGANIZATION_ID,
       SOURCE_SUBINVENTORY,
       EXPENSE_ACCOUNT,
       ENCUMBRANCE_ACCOUNT,
       RESTRICT_SUBINVENTORIES_CODE,
       UNIT_WEIGHT,
       WEIGHT_UOM_CODE,
       VOLUME_UOM_CODE,
       UNIT_VOLUME,
       RESTRICT_LOCATORS_CODE,
       LOCATION_CONTROL_CODE,
       SHRINKAGE_RATE,
       ACCEPTABLE_EARLY_DAYS,
       PLANNING_TIME_FENCE_CODE,
       DEMAND_TIME_FENCE_CODE,
       LEAD_TIME_LOT_SIZE,
       STD_LOT_SIZE,
       CUM_MANUFACTURING_LEAD_TIME,
       OVERRUN_PERCENTAGE,
       MRP_CALCULATE_ATP_FLAG,
       ACCEPTABLE_RATE_INCREASE,
       ACCEPTABLE_RATE_DECREASE,
       CUMULATIVE_TOTAL_LEAD_TIME,
       PLANNING_TIME_FENCE_DAYS,
       DEMAND_TIME_FENCE_DAYS,
       END_ASSEMBLY_PEGGING_FLAG,
       REPETITIVE_PLANNING_FLAG,
       PLANNING_EXCEPTION_SET,
       BOM_ITEM_TYPE,
       PICK_COMPONENTS_FLAG,
       REPLENISH_TO_ORDER_FLAG,
       BASE_ITEM_ID,
       ATP_COMPONENTS_FLAG,
       ATP_FLAG,
       FIXED_LEAD_TIME,
       VARIABLE_LEAD_TIME,
       WIP_SUPPLY_LOCATOR_ID,
       WIP_SUPPLY_TYPE,
       WIP_SUPPLY_SUBINVENTORY,
       COST_OF_SALES_ACCOUNT,
       SALES_ACCOUNT,
       DEFAULT_INCLUDE_IN_ROLLUP_FLAG,
       INVENTORY_ITEM_STATUS_CODE,
       INVENTORY_PLANNING_CODE,
       PLANNER_CODE,
       PLANNING_MAKE_BUY_CODE,
       FIXED_LOT_MULTIPLIER,
       ROUNDING_CONTROL_TYPE,
       CARRYING_COST,
       POSTPROCESSING_LEAD_TIME,
       PREPROCESSING_LEAD_TIME,
       SUMMARY_FLAG,
       ENABLED_FLAG,
       START_DATE_ACTIVE,
       END_DATE_ACTIVE,
       BUYER_ID,
       ACCOUNTING_RULE_ID,
       INVOICING_RULE_ID,
       OVER_SHIPMENT_TOLERANCE,
       UNDER_SHIPMENT_TOLERANCE,
       OVER_RETURN_TOLERANCE,
       UNDER_RETURN_TOLERANCE,
       EQUIPMENT_TYPE,
       RECOVERED_PART_DISP_CODE,
       DEFECT_TRACKING_ON_FLAG,
       EVENT_FLAG,
       ELECTRONIC_FLAG,
       DOWNLOADABLE_FLAG,
       VOL_DISCOUNT_EXEMPT_FLAG,
       COUPON_EXEMPT_FLAG,
       COMMS_NL_TRACKABLE_FLAG,
       ASSET_CREATION_CODE,
       COMMS_ACTIVATION_REQD_FLAG,
       ORDERABLE_ON_WEB_FLAG,
       BACK_ORDERABLE_FLAG,
       WEB_STATUS,
       INDIVISIBLE_FLAG,
       DIMENSION_UOM_CODE,
       UNIT_LENGTH,
       UNIT_WIDTH,
       UNIT_HEIGHT,
       BULK_PICKED_FLAG,
       LOT_STATUS_ENABLED,
       DEFAULT_LOT_STATUS_ID,
       SERIAL_STATUS_ENABLED,
       DEFAULT_SERIAL_STATUS_ID,
       LOT_SPLIT_ENABLED,
       LOT_MERGE_ENABLED,
       INVENTORY_CARRY_PENALTY,
       OPERATION_SLACK_PENALTY,
       FINANCING_ALLOWED_FLAG,
       EAM_ITEM_TYPE,
       EAM_ACTIVITY_TYPE_CODE,
       EAM_ACTIVITY_CAUSE_CODE,
       EAM_ACT_NOTIFICATION_FLAG,
       EAM_ACT_SHUTDOWN_STATUS,
       DUAL_UOM_CONTROL,
       SECONDARY_UOM_CODE,
       DUAL_UOM_DEVIATION_HIGH,
       DUAL_UOM_DEVIATION_LOW
       --, SERVICE_ITEM_FLAG
       --, VENDOR_WARRANTY_FLAG
       --, USAGE_ITEM_FLAG
      ,
       CONTRACT_ITEM_TYPE_CODE,
       SUBSCRIPTION_DEPEND_FLAG,
       SERV_REQ_ENABLED_CODE,
       SERV_BILLING_ENABLED_FLAG,
       SERV_IMPORTANCE_LEVEL,
       PLANNED_INV_POINT_FLAG,
       LOT_TRANSLATE_ENABLED,
       DEFAULT_SO_SOURCE_TYPE,
       CREATE_SUPPLY_FLAG,
       SUBSTITUTION_WINDOW_CODE,
       SUBSTITUTION_WINDOW_DAYS,
       SEGMENT1,
       SEGMENT2,
       SEGMENT3,
       SEGMENT4,
       SEGMENT5,
       SEGMENT6,
       SEGMENT7,
       SEGMENT8,
       SEGMENT9,
       SEGMENT10,
       SEGMENT11,
       SEGMENT12,
       SEGMENT13,
       SEGMENT14,
       SEGMENT15,
       SEGMENT16,
       SEGMENT17,
       SEGMENT18,
       SEGMENT19,
       SEGMENT20,
       ATTRIBUTE_CATEGORY,
       ATTRIBUTE1,
       ATTRIBUTE2,
       ATTRIBUTE3,
       ATTRIBUTE4,
       ATTRIBUTE5,
       -- PROGRAM_UPDATE_DATE ,
       -- OBJECT_VERSION_NUMBER,
       TRACKING_QUANTITY_IND,
       ONT_PRICING_QTY_SOURCE,
       CONSIGNED_FLAG,
       ASN_AUTOEXPIRE_FLAG,
       VMI_FORECAST_TYPE,
       EXCLUDE_FROM_BUDGET_FLAG,
       DRP_PLANNED_FLAG,
       CRITICAL_COMPONENT_FLAG,
       CONTINOUS_TRANSFER,
       CONVERGENCE,
       DIVERGENCE
        FROM MTL_SYSTEM_ITEMS_B
       WHERE INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
         AND ORGANIZATION_ID = X_ORGANIZATION_ID
         FOR UPDATE OF INVENTORY_ITEM_ID NOWAIT;
    RECINFO I_CSR%ROWTYPE;
    CURSOR C1 IS
      SELECT DESCRIPTION,
             LONG_DESCRIPTION,
             DECODE(LANGUAGE, USERENV('LANG'), 'Y', 'N') BASELANG
        FROM MTL_SYSTEM_ITEMS_TL
       WHERE INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
         AND ORGANIZATION_ID = X_ORGANIZATION_ID
      -- COMMENTED OUT. ALL TRANSLATION ROWS NEED TO BE LOCKED.
      --      AND  USERENV('LANG') IN (LANGUAGE, SOURCE_LANG)
         FOR UPDATE OF INVENTORY_ITEM_ID NOWAIT;
    L_ITEM_ID NUMBER;
    L_ORG_ID  NUMBER;
    L_RETURN_STATUS VARCHAR2(1);
  BEGIN
    --  X_MASTER_ORG_ID  => :STARTUP_INFO.MASTER_ORG_ID
    L_ITEM_ID := X_INVENTORY_ITEM_ID;
    L_ORG_ID  := X_ORGANIZATION_ID;
    OPEN I_CSR;
    FETCH I_CSR
      INTO RECINFO;
    IF (I_CSR%NOTFOUND) THEN
      CLOSE I_CSR;
      FND_MESSAGE.SET_NAME('FND', 'FORM_RECORD_DELETED');
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
    CLOSE I_CSR;
    IF (
       --
       -- DO NOT COMPARE DESCRIPTION TO THE B TABLE COLUMN;
       -- ONLY COMPARE TO TL TABLE COLUMN (C1 CURSOR BELOW).
       \*
                                                                                                     ((RECINFO.DESCRIPTION = X_DESCRIPTION)
                                                                                                      OR ((RECINFO.DESCRIPTION IS NULL) AND (X_DESCRIPTION IS NULL)))
                                                                                                 AND
                                                                                           *\
        ((RECINFO.PRIMARY_UOM_CODE = X_PRIMARY_UOM_CODE) OR
        ((RECINFO.PRIMARY_UOM_CODE IS NULL) AND
        (X_PRIMARY_UOM_CODE IS NULL)))
       --      AND ((RECINFO.PRIMARY_UNIT_OF_MEASURE = X_PRIMARY_UNIT_OF_MEASURE)
       --           OR ((RECINFO.PRIMARY_UNIT_OF_MEASURE IS NULL) AND (X_PRIMARY_UNIT_OF_MEASURE IS NULL)))
        AND
        ((RECINFO.ALLOWED_UNITS_LOOKUP_CODE = X_ALLOWED_UNITS_LOOKUP_CODE) OR
        ((RECINFO.ALLOWED_UNITS_LOOKUP_CODE IS NULL) AND
        (X_ALLOWED_UNITS_LOOKUP_CODE IS NULL))) AND
        ((RECINFO.OVERCOMPLETION_TOLERANCE_TYPE =
        X_OVERCOMPLETION_TOLERANCE_TYP) OR
        ((RECINFO.OVERCOMPLETION_TOLERANCE_TYPE IS NULL) AND
        (X_OVERCOMPLETION_TOLERANCE_TYP IS NULL))) AND
        ((RECINFO.OVERCOMPLETION_TOLERANCE_VALUE =
        X_OVERCOMPLETION_TOLERANCE_VAL) OR
        ((RECINFO.OVERCOMPLETION_TOLERANCE_VALUE IS NULL) AND
        (X_OVERCOMPLETION_TOLERANCE_VAL IS NULL))) AND
        ((RECINFO.EFFECTIVITY_CONTROL = X_EFFECTIVITY_CONTROL) OR
        ((RECINFO.EFFECTIVITY_CONTROL IS NULL) AND
        (X_EFFECTIVITY_CONTROL IS NULL))) AND
        ((RECINFO.CHECK_SHORTAGES_FLAG = X_CHECK_SHORTAGES_FLAG) OR
        ((RECINFO.CHECK_SHORTAGES_FLAG IS NULL) AND
        (X_CHECK_SHORTAGES_FLAG IS NULL))) AND
        ((RECINFO.FULL_LEAD_TIME = X_FULL_LEAD_TIME) OR
        ((RECINFO.FULL_LEAD_TIME IS NULL) AND (X_FULL_LEAD_TIME IS NULL))) AND
        ((RECINFO.ORDER_COST = X_ORDER_COST) OR
        ((RECINFO.ORDER_COST IS NULL) AND (X_ORDER_COST IS NULL))) AND
        ((RECINFO.MRP_SAFETY_STOCK_PERCENT = X_MRP_SAFETY_STOCK_PERCENT) OR
        ((RECINFO.MRP_SAFETY_STOCK_PERCENT IS NULL) AND
        (X_MRP_SAFETY_STOCK_PERCENT IS NULL))) AND
        ((RECINFO.MRP_SAFETY_STOCK_CODE = X_MRP_SAFETY_STOCK_CODE) OR
        ((RECINFO.MRP_SAFETY_STOCK_CODE IS NULL) AND
        (X_MRP_SAFETY_STOCK_CODE IS NULL))) AND
        ((RECINFO.MIN_MINMAX_QUANTITY = X_MIN_MINMAX_QUANTITY) OR
        ((RECINFO.MIN_MINMAX_QUANTITY IS NULL) AND
        (X_MIN_MINMAX_QUANTITY IS NULL))) AND
        ((RECINFO.MAX_MINMAX_QUANTITY = X_MAX_MINMAX_QUANTITY) OR
        ((RECINFO.MAX_MINMAX_QUANTITY IS NULL) AND
        (X_MAX_MINMAX_QUANTITY IS NULL))) AND
        ((RECINFO.MINIMUM_ORDER_QUANTITY = X_MINIMUM_ORDER_QUANTITY) OR
        ((RECINFO.MINIMUM_ORDER_QUANTITY IS NULL) AND
        (X_MINIMUM_ORDER_QUANTITY IS NULL))) AND
        ((RECINFO.FIXED_ORDER_QUANTITY = X_FIXED_ORDER_QUANTITY) OR
        ((RECINFO.FIXED_ORDER_QUANTITY IS NULL) AND
        (X_FIXED_ORDER_QUANTITY IS NULL))) AND
        ((RECINFO.FIXED_DAYS_SUPPLY = X_FIXED_DAYS_SUPPLY) OR
        ((RECINFO.FIXED_DAYS_SUPPLY IS NULL) AND
        (X_FIXED_DAYS_SUPPLY IS NULL))) AND
        ((RECINFO.MAXIMUM_ORDER_QUANTITY = X_MAXIMUM_ORDER_QUANTITY) OR
        ((RECINFO.MAXIMUM_ORDER_QUANTITY IS NULL) AND
        (X_MAXIMUM_ORDER_QUANTITY IS NULL))) AND
        ((RECINFO.ATP_RULE_ID = X_ATP_RULE_ID) OR
        ((RECINFO.ATP_RULE_ID IS NULL) AND (X_ATP_RULE_ID IS NULL))) AND
        ((RECINFO.PICKING_RULE_ID = X_PICKING_RULE_ID) OR
        ((RECINFO.PICKING_RULE_ID IS NULL) AND (X_PICKING_RULE_ID IS NULL))) AND
        ((RECINFO.RESERVABLE_TYPE = X_RESERVABLE_TYPE) OR
        ((RECINFO.RESERVABLE_TYPE IS NULL) AND (X_RESERVABLE_TYPE IS NULL))) AND
        ((RECINFO.POSITIVE_MEASUREMENT_ERROR = X_POSITIVE_MEASUREMENT_ERROR) OR
        ((RECINFO.POSITIVE_MEASUREMENT_ERROR IS NULL) AND
        (X_POSITIVE_MEASUREMENT_ERROR IS NULL))) AND
        ((RECINFO.NEGATIVE_MEASUREMENT_ERROR = X_NEGATIVE_MEASUREMENT_ERROR) OR
        ((RECINFO.NEGATIVE_MEASUREMENT_ERROR IS NULL) AND
        (X_NEGATIVE_MEASUREMENT_ERROR IS NULL))) AND
        ((RECINFO.ENGINEERING_ECN_CODE = X_ENGINEERING_ECN_CODE) OR
        ((RECINFO.ENGINEERING_ECN_CODE IS NULL) AND
        (X_ENGINEERING_ECN_CODE IS NULL))) AND
        ((RECINFO.ENGINEERING_ITEM_ID = X_ENGINEERING_ITEM_ID) OR
        ((RECINFO.ENGINEERING_ITEM_ID IS NULL) AND
        (X_ENGINEERING_ITEM_ID IS NULL))) AND
        ((RECINFO.ENGINEERING_DATE = X_ENGINEERING_DATE) OR
        ((RECINFO.ENGINEERING_DATE IS NULL) AND
        (X_ENGINEERING_DATE IS NULL))) AND
        ((RECINFO.SERVICE_STARTING_DELAY = X_SERVICE_STARTING_DELAY) OR
        ((RECINFO.SERVICE_STARTING_DELAY IS NULL) AND
        (X_SERVICE_STARTING_DELAY IS NULL))) AND
        ((RECINFO.SERVICEABLE_COMPONENT_FLAG = X_SERVICEABLE_COMPONENT_FLAG) OR
        ((RECINFO.SERVICEABLE_COMPONENT_FLAG IS NULL) AND
        (X_SERVICEABLE_COMPONENT_FLAG IS NULL))) AND
        (RECINFO.SERVICEABLE_PRODUCT_FLAG = X_SERVICEABLE_PRODUCT_FLAG)
       --      AND ((RECINFO.BASE_WARRANTY_SERVICE_ID = X_BASE_WARRANTY_SERVICE_ID)
       --           OR ((RECINFO.BASE_WARRANTY_SERVICE_ID IS NULL) AND (X_BASE_WARRANTY_SERVICE_ID IS NULL)))
        AND ((RECINFO.PAYMENT_TERMS_ID = X_PAYMENT_TERMS_ID) OR
        ((RECINFO.PAYMENT_TERMS_ID IS NULL) AND
        (X_PAYMENT_TERMS_ID IS NULL))) AND
        ((RECINFO.PREVENTIVE_MAINTENANCE_FLAG =
        X_PREVENTIVE_MAINTENANCE_FLAG) OR
        ((RECINFO.PREVENTIVE_MAINTENANCE_FLAG IS NULL) AND
        (X_PREVENTIVE_MAINTENANCE_FLAG IS NULL)))
       --      AND ((RECINFO.PRIMARY_SPECIALIST_ID = X_PRIMARY_SPECIALIST_ID)
       --           OR ((RECINFO.PRIMARY_SPECIALIST_ID IS NULL) AND (X_PRIMARY_SPECIALIST_ID IS NULL)))
       --      AND ((RECINFO.SECONDARY_SPECIALIST_ID = X_SECONDARY_SPECIALIST_ID)
       --           OR ((RECINFO.SECONDARY_SPECIALIST_ID IS NULL) AND (X_SECONDARY_SPECIALIST_ID IS NULL)))
       --      AND ((RECINFO.SERVICEABLE_ITEM_CLASS_ID = X_SERVICEABLE_ITEM_CLASS_ID)
       --           OR ((RECINFO.SERVICEABLE_ITEM_CLASS_ID IS NULL) AND (X_SERVICEABLE_ITEM_CLASS_ID IS NULL)))
       --      AND ((RECINFO.TIME_BILLABLE_FLAG = X_TIME_BILLABLE_FLAG)
       --           OR ((RECINFO.TIME_BILLABLE_FLAG IS NULL) AND (X_TIME_BILLABLE_FLAG IS NULL)))
        AND ((RECINFO.MATERIAL_BILLABLE_FLAG = X_MATERIAL_BILLABLE_FLAG) OR
        ((RECINFO.MATERIAL_BILLABLE_FLAG IS NULL) AND
        (X_MATERIAL_BILLABLE_FLAG IS NULL)))
       --      AND ((RECINFO.EXPENSE_BILLABLE_FLAG = X_EXPENSE_BILLABLE_FLAG)
       --           OR ((RECINFO.EXPENSE_BILLABLE_FLAG IS NULL) AND (X_EXPENSE_BILLABLE_FLAG IS NULL)))
        AND ((RECINFO.PRORATE_SERVICE_FLAG = X_PRORATE_SERVICE_FLAG) OR
        ((RECINFO.PRORATE_SERVICE_FLAG IS NULL) AND
        (X_PRORATE_SERVICE_FLAG IS NULL))) AND
        ((RECINFO.COVERAGE_SCHEDULE_ID = X_COVERAGE_SCHEDULE_ID) OR
        ((RECINFO.COVERAGE_SCHEDULE_ID IS NULL) AND
        (X_COVERAGE_SCHEDULE_ID IS NULL))) AND
        ((RECINFO.SERVICE_DURATION_PERIOD_CODE =
        X_SERVICE_DURATION_PERIOD_CODE) OR
        ((RECINFO.SERVICE_DURATION_PERIOD_CODE IS NULL) AND
        (X_SERVICE_DURATION_PERIOD_CODE IS NULL))) AND
        ((RECINFO.SERVICE_DURATION = X_SERVICE_DURATION) OR
        ((RECINFO.SERVICE_DURATION IS NULL) AND
        (X_SERVICE_DURATION IS NULL)))
       --      AND ((RECINFO.WARRANTY_VENDOR_ID = X_WARRANTY_VENDOR_ID)
       --           OR ((RECINFO.WARRANTY_VENDOR_ID IS NULL) AND (X_WARRANTY_VENDOR_ID IS NULL)))
       --      AND ((RECINFO.MAX_WARRANTY_AMOUNT = X_MAX_WARRANTY_AMOUNT)
       --           OR ((RECINFO.MAX_WARRANTY_AMOUNT IS NULL) AND (X_MAX_WARRANTY_AMOUNT IS NULL)))
       --      AND ((RECINFO.RESPONSE_TIME_PERIOD_CODE = X_RESPONSE_TIME_PERIOD_CODE)
       --           OR ((RECINFO.RESPONSE_TIME_PERIOD_CODE IS NULL) AND (X_RESPONSE_TIME_PERIOD_CODE IS NULL)))
       --      AND ((RECINFO.RESPONSE_TIME_VALUE = X_RESPONSE_TIME_VALUE)
       --           OR ((RECINFO.RESPONSE_TIME_VALUE IS NULL) AND (X_RESPONSE_TIME_VALUE IS NULL)))
       --      AND ((RECINFO.NEW_REVISION_CODE = X_NEW_REVISION_CODE)
       --           OR ((RECINFO.NEW_REVISION_CODE IS NULL) AND (X_NEW_REVISION_CODE IS NULL)))
        AND (RECINFO.INVOICEABLE_ITEM_FLAG = X_INVOICEABLE_ITEM_FLAG) AND
        ((RECINFO.TAX_CODE = X_TAX_CODE) OR
        ((RECINFO.TAX_CODE IS NULL) AND (X_TAX_CODE IS NULL))) AND
        (RECINFO.INVOICE_ENABLED_FLAG = X_INVOICE_ENABLED_FLAG) AND
        (RECINFO.MUST_USE_APPROVED_VENDOR_FLAG =
        X_MUST_USE_APPROVED_VENDOR_FLA)
       --      AND ((RECINFO.REQUEST_ID = X_REQUEST_ID)
       --           OR ((RECINFO.REQUEST_ID IS NULL) AND (X_REQUEST_ID IS NULL)))
        AND (RECINFO.OUTSIDE_OPERATION_FLAG = X_OUTSIDE_OPERATION_FLAG) AND
        ((RECINFO.OUTSIDE_OPERATION_UOM_TYPE = X_OUTSIDE_OPERATION_UOM_TYPE) OR
        ((RECINFO.OUTSIDE_OPERATION_UOM_TYPE IS NULL) AND
        (X_OUTSIDE_OPERATION_UOM_TYPE IS NULL))) AND
        ((RECINFO.SAFETY_STOCK_BUCKET_DAYS = X_SAFETY_STOCK_BUCKET_DAYS) OR
        ((RECINFO.SAFETY_STOCK_BUCKET_DAYS IS NULL) AND
        (X_SAFETY_STOCK_BUCKET_DAYS IS NULL))) AND
        ((RECINFO.AUTO_REDUCE_MPS = X_AUTO_REDUCE_MPS) OR
        ((RECINFO.AUTO_REDUCE_MPS IS NULL) AND (X_AUTO_REDUCE_MPS IS NULL))) AND
        (RECINFO.COSTING_ENABLED_FLAG = X_COSTING_ENABLED_FLAG) AND
        (RECINFO.AUTO_CREATED_CONFIG_FLAG = X_AUTO_CREATED_CONFIG_FLAG) AND
        (RECINFO.CYCLE_COUNT_ENABLED_FLAG = X_CYCLE_COUNT_ENABLED_FLAG) AND
        ((RECINFO.ITEM_TYPE = X_ITEM_TYPE) OR
        ((RECINFO.ITEM_TYPE IS NULL) AND (X_ITEM_TYPE IS NULL)))
       --      AND ((RECINFO.MODEL_CONFIG_CLAUSE_NAME = X_MODEL_CONFIG_CLAUSE_NAME)
       --           OR ((RECINFO.MODEL_CONFIG_CLAUSE_NAME IS NULL) AND (X_MODEL_CONFIG_CLAUSE_NAME IS NULL)))
        AND ((RECINFO.SHIP_MODEL_COMPLETE_FLAG = X_SHIP_MODEL_COMPLETE_FLAG) OR
        ((RECINFO.SHIP_MODEL_COMPLETE_FLAG IS NULL) AND
        (X_SHIP_MODEL_COMPLETE_FLAG IS NULL))) AND
        ((RECINFO.MRP_PLANNING_CODE = X_MRP_PLANNING_CODE) OR
        ((RECINFO.MRP_PLANNING_CODE IS NULL) AND
        (X_MRP_PLANNING_CODE IS NULL))) AND
        ((RECINFO.RETURN_INSPECTION_REQUIREMENT =
        X_RETURN_INSPECTION_REQUIREMEN) OR
        ((RECINFO.RETURN_INSPECTION_REQUIREMENT IS NULL) AND
        (X_RETURN_INSPECTION_REQUIREMEN IS NULL))) AND
        ((RECINFO.ATO_FORECAST_CONTROL = X_ATO_FORECAST_CONTROL) OR
        ((RECINFO.ATO_FORECAST_CONTROL IS NULL) AND
        (X_ATO_FORECAST_CONTROL IS NULL))) AND
        ((RECINFO.RELEASE_TIME_FENCE_CODE = X_RELEASE_TIME_FENCE_CODE) OR
        ((RECINFO.RELEASE_TIME_FENCE_CODE IS NULL) AND
        (X_RELEASE_TIME_FENCE_CODE IS NULL))) AND
        ((RECINFO.RELEASE_TIME_FENCE_DAYS = X_RELEASE_TIME_FENCE_DAYS) OR
        ((RECINFO.RELEASE_TIME_FENCE_DAYS IS NULL) AND
        (X_RELEASE_TIME_FENCE_DAYS IS NULL))) AND
        ((RECINFO.CONTAINER_ITEM_FLAG = X_CONTAINER_ITEM_FLAG) OR
        ((RECINFO.CONTAINER_ITEM_FLAG IS NULL) AND
        (X_CONTAINER_ITEM_FLAG IS NULL))) AND
        ((RECINFO.VEHICLE_ITEM_FLAG = X_VEHICLE_ITEM_FLAG) OR
        ((RECINFO.VEHICLE_ITEM_FLAG IS NULL) AND
        (X_VEHICLE_ITEM_FLAG IS NULL))) AND
        ((RECINFO.MAXIMUM_LOAD_WEIGHT = X_MAXIMUM_LOAD_WEIGHT) OR
        ((RECINFO.MAXIMUM_LOAD_WEIGHT IS NULL) AND
        (X_MAXIMUM_LOAD_WEIGHT IS NULL))) AND
        ((RECINFO.MINIMUM_FILL_PERCENT = X_MINIMUM_FILL_PERCENT) OR
        ((RECINFO.MINIMUM_FILL_PERCENT IS NULL) AND
        (X_MINIMUM_FILL_PERCENT IS NULL))) AND
        ((RECINFO.CONTAINER_TYPE_CODE = X_CONTAINER_TYPE_CODE) OR
        ((RECINFO.CONTAINER_TYPE_CODE IS NULL) AND
        (X_CONTAINER_TYPE_CODE IS NULL))) AND
        ((RECINFO.INTERNAL_VOLUME = X_INTERNAL_VOLUME) OR
        ((RECINFO.INTERNAL_VOLUME IS NULL) AND (X_INTERNAL_VOLUME IS NULL)))
       --      AND ((RECINFO.WH_UPDATE_DATE = X_WH_UPDATE_DATE)
       --           OR ((RECINFO.WH_UPDATE_DATE IS NULL) AND (X_WH_UPDATE_DATE IS NULL)))
        AND ((RECINFO.PRODUCT_FAMILY_ITEM_ID = X_PRODUCT_FAMILY_ITEM_ID) OR
        ((RECINFO.PRODUCT_FAMILY_ITEM_ID IS NULL) AND
        (X_PRODUCT_FAMILY_ITEM_ID IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE_CATEGORY = X_GLOBAL_ATTRIBUTE_CATEGORY) OR
        ((RECINFO.GLOBAL_ATTRIBUTE_CATEGORY IS NULL) AND
        (X_GLOBAL_ATTRIBUTE_CATEGORY IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE1 = X_GLOBAL_ATTRIBUTE1) OR
        ((RECINFO.GLOBAL_ATTRIBUTE1 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE1 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE2 = X_GLOBAL_ATTRIBUTE2) OR
        ((RECINFO.GLOBAL_ATTRIBUTE2 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE2 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE3 = X_GLOBAL_ATTRIBUTE3) OR
        ((RECINFO.GLOBAL_ATTRIBUTE3 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE3 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE4 = X_GLOBAL_ATTRIBUTE4) OR
        ((RECINFO.GLOBAL_ATTRIBUTE4 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE4 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE5 = X_GLOBAL_ATTRIBUTE5) OR
        ((RECINFO.GLOBAL_ATTRIBUTE5 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE5 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE6 = X_GLOBAL_ATTRIBUTE6) OR
        ((RECINFO.GLOBAL_ATTRIBUTE6 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE6 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE7 = X_GLOBAL_ATTRIBUTE7) OR
        ((RECINFO.GLOBAL_ATTRIBUTE7 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE7 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE8 = X_GLOBAL_ATTRIBUTE8) OR
        ((RECINFO.GLOBAL_ATTRIBUTE8 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE8 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE9 = X_GLOBAL_ATTRIBUTE9) OR
        ((RECINFO.GLOBAL_ATTRIBUTE9 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE9 IS NULL))) AND
        ((RECINFO.GLOBAL_ATTRIBUTE10 = X_GLOBAL_ATTRIBUTE10) OR
        ((RECINFO.GLOBAL_ATTRIBUTE10 IS NULL) AND
        (X_GLOBAL_ATTRIBUTE10 IS NULL))) AND
        ((RECINFO.PURCHASING_TAX_CODE = X_PURCHASING_TAX_CODE) OR
        ((RECINFO.PURCHASING_TAX_CODE IS NULL) AND
        (X_PURCHASING_TAX_CODE IS NULL))) AND
        ((RECINFO.ATTRIBUTE6 = X_ATTRIBUTE6) OR
        ((RECINFO.ATTRIBUTE6 IS NULL) AND (X_ATTRIBUTE6 IS NULL))) AND
        ((RECINFO.ATTRIBUTE7 = X_ATTRIBUTE7) OR
        ((RECINFO.ATTRIBUTE7 IS NULL) AND (X_ATTRIBUTE7 IS NULL))) AND
        ((RECINFO.ATTRIBUTE8 = X_ATTRIBUTE8) OR
        ((RECINFO.ATTRIBUTE8 IS NULL) AND (X_ATTRIBUTE8 IS NULL))) AND
        ((RECINFO.ATTRIBUTE9 = X_ATTRIBUTE9) OR
        ((RECINFO.ATTRIBUTE9 IS NULL) AND (X_ATTRIBUTE9 IS NULL))) AND
        ((RECINFO.ATTRIBUTE10 = X_ATTRIBUTE10) OR
        ((RECINFO.ATTRIBUTE10 IS NULL) AND (X_ATTRIBUTE10 IS NULL))) AND
        ((RECINFO.ATTRIBUTE11 = X_ATTRIBUTE11) OR
        ((RECINFO.ATTRIBUTE11 IS NULL) AND (X_ATTRIBUTE11 IS NULL))) AND
        ((RECINFO.ATTRIBUTE12 = X_ATTRIBUTE12) OR
        ((RECINFO.ATTRIBUTE12 IS NULL) AND (X_ATTRIBUTE12 IS NULL))) AND
        ((RECINFO.ATTRIBUTE13 = X_ATTRIBUTE13) OR
        ((RECINFO.ATTRIBUTE13 IS NULL) AND (X_ATTRIBUTE13 IS NULL))) AND
        ((RECINFO.ATTRIBUTE14 = X_ATTRIBUTE14) OR
        ((RECINFO.ATTRIBUTE14 IS NULL) AND (X_ATTRIBUTE14 IS NULL))) AND
        ((RECINFO.ATTRIBUTE15 = X_ATTRIBUTE15) OR
        ((RECINFO.ATTRIBUTE15 IS NULL) AND (X_ATTRIBUTE15 IS NULL))) AND
        (RECINFO.PURCHASING_ITEM_FLAG = X_PURCHASING_ITEM_FLAG) AND
        (RECINFO.SHIPPABLE_ITEM_FLAG = X_SHIPPABLE_ITEM_FLAG) AND
        (RECINFO.CUSTOMER_ORDER_FLAG = X_CUSTOMER_ORDER_FLAG) AND
        (RECINFO.INTERNAL_ORDER_FLAG = X_INTERNAL_ORDER_FLAG) AND
        (RECINFO.INVENTORY_ITEM_FLAG = X_INVENTORY_ITEM_FLAG) AND
        (RECINFO.ENG_ITEM_FLAG = X_ENG_ITEM_FLAG) AND
        (RECINFO.INVENTORY_ASSET_FLAG = X_INVENTORY_ASSET_FLAG) AND
        (RECINFO.PURCHASING_ENABLED_FLAG = X_PURCHASING_ENABLED_FLAG) AND
        (RECINFO.CUSTOMER_ORDER_ENABLED_FLAG = X_CUSTOMER_ORDER_ENABLED_FLAG) AND
        (RECINFO.INTERNAL_ORDER_ENABLED_FLAG = X_INTERNAL_ORDER_ENABLED_FLAG) AND
        (RECINFO.SO_TRANSACTIONS_FLAG = X_SO_TRANSACTIONS_FLAG) AND
        (RECINFO.MTL_TRANSACTIONS_ENABLED_FLAG =
        X_MTL_TRANSACTIONS_ENABLED_FLA) AND
        (RECINFO.STOCK_ENABLED_FLAG = X_STOCK_ENABLED_FLAG) AND
        (RECINFO.BOM_ENABLED_FLAG = X_BOM_ENABLED_FLAG) AND
        (RECINFO.BUILD_IN_WIP_FLAG = X_BUILD_IN_WIP_FLAG) AND
        ((RECINFO.REVISION_QTY_CONTROL_CODE = X_REVISION_QTY_CONTROL_CODE) OR
        ((RECINFO.REVISION_QTY_CONTROL_CODE IS NULL) AND
        (X_REVISION_QTY_CONTROL_CODE IS NULL))) AND
        ((RECINFO.ITEM_CATALOG_GROUP_ID = X_ITEM_CATALOG_GROUP_ID) OR
        ((RECINFO.ITEM_CATALOG_GROUP_ID IS NULL) AND
        (X_ITEM_CATALOG_GROUP_ID IS NULL))) AND
        ((RECINFO.CATALOG_STATUS_FLAG = X_CATALOG_STATUS_FLAG) OR
        ((RECINFO.CATALOG_STATUS_FLAG IS NULL) AND
        (X_CATALOG_STATUS_FLAG IS NULL))) AND
        ((RECINFO.RETURNABLE_FLAG = X_RETURNABLE_FLAG) OR
        ((RECINFO.RETURNABLE_FLAG IS NULL) AND (X_RETURNABLE_FLAG IS NULL))) AND
        ((RECINFO.DEFAULT_SHIPPING_ORG = X_DEFAULT_SHIPPING_ORG) OR
        ((RECINFO.DEFAULT_SHIPPING_ORG IS NULL) AND
        (X_DEFAULT_SHIPPING_ORG IS NULL))) AND
        ((RECINFO.COLLATERAL_FLAG = X_COLLATERAL_FLAG) OR
        ((RECINFO.COLLATERAL_FLAG IS NULL) AND (X_COLLATERAL_FLAG IS NULL))) AND
        ((RECINFO.TAXABLE_FLAG = X_TAXABLE_FLAG) OR
        ((RECINFO.TAXABLE_FLAG IS NULL) AND (X_TAXABLE_FLAG IS NULL))) AND
        ((RECINFO.QTY_RCV_EXCEPTION_CODE = X_QTY_RCV_EXCEPTION_CODE) OR
        ((RECINFO.QTY_RCV_EXCEPTION_CODE IS NULL) AND
        (X_QTY_RCV_EXCEPTION_CODE IS NULL))) AND
        ((RECINFO.ALLOW_ITEM_DESC_UPDATE_FLAG =
        X_ALLOW_ITEM_DESC_UPDATE_FLAG) OR
        ((RECINFO.ALLOW_ITEM_DESC_UPDATE_FLAG IS NULL) AND
        (X_ALLOW_ITEM_DESC_UPDATE_FLAG IS NULL))) AND
        ((RECINFO.INSPECTION_REQUIRED_FLAG = X_INSPECTION_REQUIRED_FLAG) OR
        ((RECINFO.INSPECTION_REQUIRED_FLAG IS NULL) AND
        (X_INSPECTION_REQUIRED_FLAG IS NULL))) AND
        ((RECINFO.RECEIPT_REQUIRED_FLAG = X_RECEIPT_REQUIRED_FLAG) OR
        ((RECINFO.RECEIPT_REQUIRED_FLAG IS NULL) AND
        (X_RECEIPT_REQUIRED_FLAG IS NULL))) AND
        ((RECINFO.MARKET_PRICE = X_MARKET_PRICE) OR
        ((RECINFO.MARKET_PRICE IS NULL) AND (X_MARKET_PRICE IS NULL))) AND
        ((RECINFO.HAZARD_CLASS_ID = X_HAZARD_CLASS_ID) OR
        ((RECINFO.HAZARD_CLASS_ID IS NULL) AND (X_HAZARD_CLASS_ID IS NULL))) AND
        ((RECINFO.RFQ_REQUIRED_FLAG = X_RFQ_REQUIRED_FLAG) OR
        ((RECINFO.RFQ_REQUIRED_FLAG IS NULL) AND
        (X_RFQ_REQUIRED_FLAG IS NULL))) AND
        ((RECINFO.QTY_RCV_TOLERANCE = X_QTY_RCV_TOLERANCE) OR
        ((RECINFO.QTY_RCV_TOLERANCE IS NULL) AND
        (X_QTY_RCV_TOLERANCE IS NULL))) AND
        ((RECINFO.LIST_PRICE_PER_UNIT = X_LIST_PRICE_PER_UNIT) OR
        ((RECINFO.LIST_PRICE_PER_UNIT IS NULL) AND
        (X_LIST_PRICE_PER_UNIT IS NULL))) AND
        ((RECINFO.UN_NUMBER_ID = X_UN_NUMBER_ID) OR
        ((RECINFO.UN_NUMBER_ID IS NULL) AND (X_UN_NUMBER_ID IS NULL))) AND
        ((RECINFO.PRICE_TOLERANCE_PERCENT = X_PRICE_TOLERANCE_PERCENT) OR
        ((RECINFO.PRICE_TOLERANCE_PERCENT IS NULL) AND
        (X_PRICE_TOLERANCE_PERCENT IS NULL))) AND
        ((RECINFO.ASSET_CATEGORY_ID = X_ASSET_CATEGORY_ID) OR
        ((RECINFO.ASSET_CATEGORY_ID IS NULL) AND
        (X_ASSET_CATEGORY_ID IS NULL))) AND
        ((RECINFO.ROUNDING_FACTOR = X_ROUNDING_FACTOR) OR
        ((RECINFO.ROUNDING_FACTOR IS NULL) AND (X_ROUNDING_FACTOR IS NULL))) AND
        ((RECINFO.UNIT_OF_ISSUE = X_UNIT_OF_ISSUE) OR
        ((RECINFO.UNIT_OF_ISSUE IS NULL) AND (X_UNIT_OF_ISSUE IS NULL))) AND
        ((RECINFO.ENFORCE_SHIP_TO_LOCATION_CODE =
        X_ENFORCE_SHIP_TO_LOCATION_COD) OR
        ((RECINFO.ENFORCE_SHIP_TO_LOCATION_CODE IS NULL) AND
        (X_ENFORCE_SHIP_TO_LOCATION_COD IS NULL))) AND
        ((RECINFO.ALLOW_SUBSTITUTE_RECEIPTS_FLAG =
        X_ALLOW_SUBSTITUTE_RECEIPTS_FL) OR
        ((RECINFO.ALLOW_SUBSTITUTE_RECEIPTS_FLAG IS NULL) AND
        (X_ALLOW_SUBSTITUTE_RECEIPTS_FL IS NULL))) AND
        ((RECINFO.ALLOW_UNORDERED_RECEIPTS_FLAG =
        X_ALLOW_UNORDERED_RECEIPTS_FLA) OR
        ((RECINFO.ALLOW_UNORDERED_RECEIPTS_FLAG IS NULL) AND
        (X_ALLOW_UNORDERED_RECEIPTS_FLA IS NULL))) AND
        ((RECINFO.ALLOW_EXPRESS_DELIVERY_FLAG =
        X_ALLOW_EXPRESS_DELIVERY_FLAG) OR
        ((RECINFO.ALLOW_EXPRESS_DELIVERY_FLAG IS NULL) AND
        (X_ALLOW_EXPRESS_DELIVERY_FLAG IS NULL))) AND
        ((RECINFO.DAYS_EARLY_RECEIPT_ALLOWED = X_DAYS_EARLY_RECEIPT_ALLOWED) OR
        ((RECINFO.DAYS_EARLY_RECEIPT_ALLOWED IS NULL) AND
        (X_DAYS_EARLY_RECEIPT_ALLOWED IS NULL))) AND
        ((RECINFO.DAYS_LATE_RECEIPT_ALLOWED = X_DAYS_LATE_RECEIPT_ALLOWED) OR
        ((RECINFO.DAYS_LATE_RECEIPT_ALLOWED IS NULL) AND
        (X_DAYS_LATE_RECEIPT_ALLOWED IS NULL))) AND
        ((RECINFO.RECEIPT_DAYS_EXCEPTION_CODE =
        X_RECEIPT_DAYS_EXCEPTION_CODE) OR
        ((RECINFO.RECEIPT_DAYS_EXCEPTION_CODE IS NULL) AND
        (X_RECEIPT_DAYS_EXCEPTION_CODE IS NULL))) AND
        ((RECINFO.RECEIVING_ROUTING_ID = X_RECEIVING_ROUTING_ID) OR
        ((RECINFO.RECEIVING_ROUTING_ID IS NULL) AND
        (X_RECEIVING_ROUTING_ID IS NULL))) AND
        ((RECINFO.INVOICE_CLOSE_TOLERANCE = X_INVOICE_CLOSE_TOLERANCE) OR
        ((RECINFO.INVOICE_CLOSE_TOLERANCE IS NULL) AND
        (X_INVOICE_CLOSE_TOLERANCE IS NULL))) AND
        ((RECINFO.RECEIVE_CLOSE_TOLERANCE = X_RECEIVE_CLOSE_TOLERANCE) OR
        ((RECINFO.RECEIVE_CLOSE_TOLERANCE IS NULL) AND
        (X_RECEIVE_CLOSE_TOLERANCE IS NULL))) AND
        ((RECINFO.AUTO_LOT_ALPHA_PREFIX = X_AUTO_LOT_ALPHA_PREFIX) OR
        ((RECINFO.AUTO_LOT_ALPHA_PREFIX IS NULL) AND
        (X_AUTO_LOT_ALPHA_PREFIX IS NULL))) AND
        ((RECINFO.START_AUTO_LOT_NUMBER = X_START_AUTO_LOT_NUMBER) OR
        ((RECINFO.START_AUTO_LOT_NUMBER IS NULL) AND
        (X_START_AUTO_LOT_NUMBER IS NULL))) AND
        ((RECINFO.LOT_CONTROL_CODE = X_LOT_CONTROL_CODE) OR
        ((RECINFO.LOT_CONTROL_CODE IS NULL) AND
        (X_LOT_CONTROL_CODE IS NULL))) AND
        ((RECINFO.SHELF_LIFE_CODE = X_SHELF_LIFE_CODE) OR
        ((RECINFO.SHELF_LIFE_CODE IS NULL) AND (X_SHELF_LIFE_CODE IS NULL))) AND
        ((RECINFO.SHELF_LIFE_DAYS = X_SHELF_LIFE_DAYS) OR
        ((RECINFO.SHELF_LIFE_DAYS IS NULL) AND (X_SHELF_LIFE_DAYS IS NULL))) AND
        ((RECINFO.SERIAL_NUMBER_CONTROL_CODE = X_SERIAL_NUMBER_CONTROL_CODE) OR
        ((RECINFO.SERIAL_NUMBER_CONTROL_CODE IS NULL) AND
        (X_SERIAL_NUMBER_CONTROL_CODE IS NULL))) AND
        ((RECINFO.START_AUTO_SERIAL_NUMBER = X_START_AUTO_SERIAL_NUMBER) OR
        ((RECINFO.START_AUTO_SERIAL_NUMBER IS NULL) AND
        (X_START_AUTO_SERIAL_NUMBER IS NULL))) AND
        ((RECINFO.AUTO_SERIAL_ALPHA_PREFIX = X_AUTO_SERIAL_ALPHA_PREFIX) OR
        ((RECINFO.AUTO_SERIAL_ALPHA_PREFIX IS NULL) AND
        (X_AUTO_SERIAL_ALPHA_PREFIX IS NULL))) AND
        ((RECINFO.SOURCE_TYPE = X_SOURCE_TYPE) OR
        ((RECINFO.SOURCE_TYPE IS NULL) AND (X_SOURCE_TYPE IS NULL))) AND
        ((RECINFO.SOURCE_ORGANIZATION_ID = X_SOURCE_ORGANIZATION_ID) OR
        ((RECINFO.SOURCE_ORGANIZATION_ID IS NULL) AND
        (X_SOURCE_ORGANIZATION_ID IS NULL))) AND
        ((RECINFO.SOURCE_SUBINVENTORY = X_SOURCE_SUBINVENTORY) OR
        ((RECINFO.SOURCE_SUBINVENTORY IS NULL) AND
        (X_SOURCE_SUBINVENTORY IS NULL))) AND
        ((RECINFO.EXPENSE_ACCOUNT = X_EXPENSE_ACCOUNT) OR
        ((RECINFO.EXPENSE_ACCOUNT IS NULL) AND (X_EXPENSE_ACCOUNT IS NULL))) AND
        ((RECINFO.ENCUMBRANCE_ACCOUNT = X_ENCUMBRANCE_ACCOUNT) OR
        ((RECINFO.ENCUMBRANCE_ACCOUNT IS NULL) AND
        (X_ENCUMBRANCE_ACCOUNT IS NULL))) AND
        ((RECINFO.RESTRICT_SUBINVENTORIES_CODE =
        X_RESTRICT_SUBINVENTORIES_CODE) OR
        ((RECINFO.RESTRICT_SUBINVENTORIES_CODE IS NULL) AND
        (X_RESTRICT_SUBINVENTORIES_CODE IS NULL))) AND
        ((RECINFO.UNIT_WEIGHT = X_UNIT_WEIGHT) OR
        ((RECINFO.UNIT_WEIGHT IS NULL) AND (X_UNIT_WEIGHT IS NULL))) AND
        ((RECINFO.WEIGHT_UOM_CODE = X_WEIGHT_UOM_CODE) OR
        ((RECINFO.WEIGHT_UOM_CODE IS NULL) AND (X_WEIGHT_UOM_CODE IS NULL))) AND
        ((RECINFO.VOLUME_UOM_CODE = X_VOLUME_UOM_CODE) OR
        ((RECINFO.VOLUME_UOM_CODE IS NULL) AND (X_VOLUME_UOM_CODE IS NULL))) AND
        ((RECINFO.UNIT_VOLUME = X_UNIT_VOLUME) OR
        ((RECINFO.UNIT_VOLUME IS NULL) AND (X_UNIT_VOLUME IS NULL))) AND
        ((RECINFO.RESTRICT_LOCATORS_CODE = X_RESTRICT_LOCATORS_CODE) OR
        ((RECINFO.RESTRICT_LOCATORS_CODE IS NULL) AND
        (X_RESTRICT_LOCATORS_CODE IS NULL))) AND
        ((RECINFO.LOCATION_CONTROL_CODE = X_LOCATION_CONTROL_CODE) OR
        ((RECINFO.LOCATION_CONTROL_CODE IS NULL) AND
        (X_LOCATION_CONTROL_CODE IS NULL))) AND
        ((RECINFO.SHRINKAGE_RATE = X_SHRINKAGE_RATE) OR
        ((RECINFO.SHRINKAGE_RATE IS NULL) AND (X_SHRINKAGE_RATE IS NULL))) AND
        ((RECINFO.ACCEPTABLE_EARLY_DAYS = X_ACCEPTABLE_EARLY_DAYS) OR
        ((RECINFO.ACCEPTABLE_EARLY_DAYS IS NULL) AND
        (X_ACCEPTABLE_EARLY_DAYS IS NULL))) AND
        ((RECINFO.PLANNING_TIME_FENCE_CODE = X_PLANNING_TIME_FENCE_CODE) OR
        ((RECINFO.PLANNING_TIME_FENCE_CODE IS NULL) AND
        (X_PLANNING_TIME_FENCE_CODE IS NULL))) AND
        ((RECINFO.DEMAND_TIME_FENCE_CODE = X_DEMAND_TIME_FENCE_CODE) OR
        ((RECINFO.DEMAND_TIME_FENCE_CODE IS NULL) AND
        (X_DEMAND_TIME_FENCE_CODE IS NULL))) AND
        ((RECINFO.LEAD_TIME_LOT_SIZE = X_LEAD_TIME_LOT_SIZE) OR
        ((RECINFO.LEAD_TIME_LOT_SIZE IS NULL) AND
        (X_LEAD_TIME_LOT_SIZE IS NULL))) AND
        ((RECINFO.STD_LOT_SIZE = X_STD_LOT_SIZE) OR
        ((RECINFO.STD_LOT_SIZE IS NULL) AND (X_STD_LOT_SIZE IS NULL))) AND
        ((RECINFO.CUM_MANUFACTURING_LEAD_TIME =
        X_CUM_MANUFACTURING_LEAD_TIME) OR
        ((RECINFO.CUM_MANUFACTURING_LEAD_TIME IS NULL) AND
        (X_CUM_MANUFACTURING_LEAD_TIME IS NULL))) AND
        ((RECINFO.OVERRUN_PERCENTAGE = X_OVERRUN_PERCENTAGE) OR
        ((RECINFO.OVERRUN_PERCENTAGE IS NULL) AND
        (X_OVERRUN_PERCENTAGE IS NULL))) AND
        ((RECINFO.MRP_CALCULATE_ATP_FLAG = X_MRP_CALCULATE_ATP_FLAG) OR
        ((RECINFO.MRP_CALCULATE_ATP_FLAG IS NULL) AND
        (X_MRP_CALCULATE_ATP_FLAG IS NULL))) AND
        ((RECINFO.ACCEPTABLE_RATE_INCREASE = X_ACCEPTABLE_RATE_INCREASE) OR
        ((RECINFO.ACCEPTABLE_RATE_INCREASE IS NULL) AND
        (X_ACCEPTABLE_RATE_INCREASE IS NULL))) AND
        ((RECINFO.ACCEPTABLE_RATE_DECREASE = X_ACCEPTABLE_RATE_DECREASE) OR
        ((RECINFO.ACCEPTABLE_RATE_DECREASE IS NULL) AND
        (X_ACCEPTABLE_RATE_DECREASE IS NULL))) AND
        ((RECINFO.CUMULATIVE_TOTAL_LEAD_TIME = X_CUMULATIVE_TOTAL_LEAD_TIME) OR
        ((RECINFO.CUMULATIVE_TOTAL_LEAD_TIME IS NULL) AND
        (X_CUMULATIVE_TOTAL_LEAD_TIME IS NULL))) AND
        ((RECINFO.PLANNING_TIME_FENCE_DAYS = X_PLANNING_TIME_FENCE_DAYS) OR
        ((RECINFO.PLANNING_TIME_FENCE_DAYS IS NULL) AND
        (X_PLANNING_TIME_FENCE_DAYS IS NULL))) AND
        ((RECINFO.DEMAND_TIME_FENCE_DAYS = X_DEMAND_TIME_FENCE_DAYS) OR
        ((RECINFO.DEMAND_TIME_FENCE_DAYS IS NULL) AND
        (X_DEMAND_TIME_FENCE_DAYS IS NULL))) AND
        ((RECINFO.END_ASSEMBLY_PEGGING_FLAG = X_END_ASSEMBLY_PEGGING_FLAG) OR
        ((RECINFO.END_ASSEMBLY_PEGGING_FLAG IS NULL) AND
        (X_END_ASSEMBLY_PEGGING_FLAG IS NULL))) AND
        ((RECINFO.REPETITIVE_PLANNING_FLAG = X_REPETITIVE_PLANNING_FLAG) OR
        ((RECINFO.REPETITIVE_PLANNING_FLAG IS NULL) AND
        (X_REPETITIVE_PLANNING_FLAG IS NULL))) AND
        ((RECINFO.PLANNING_EXCEPTION_SET = X_PLANNING_EXCEPTION_SET) OR
        ((RECINFO.PLANNING_EXCEPTION_SET IS NULL) AND
        (X_PLANNING_EXCEPTION_SET IS NULL))) AND
        (RECINFO.BOM_ITEM_TYPE = X_BOM_ITEM_TYPE) AND
        (RECINFO.PICK_COMPONENTS_FLAG = X_PICK_COMPONENTS_FLAG) AND
        (RECINFO.REPLENISH_TO_ORDER_FLAG = X_REPLENISH_TO_ORDER_FLAG) AND
        ((RECINFO.BASE_ITEM_ID = X_BASE_ITEM_ID) OR
        ((RECINFO.BASE_ITEM_ID IS NULL) AND (X_BASE_ITEM_ID IS NULL))) AND
        (RECINFO.ATP_COMPONENTS_FLAG = X_ATP_COMPONENTS_FLAG) AND
        (RECINFO.ATP_FLAG = X_ATP_FLAG) AND
        ((RECINFO.FIXED_LEAD_TIME = X_FIXED_LEAD_TIME) OR
        ((RECINFO.FIXED_LEAD_TIME IS NULL) AND (X_FIXED_LEAD_TIME IS NULL))) AND
        ((RECINFO.VARIABLE_LEAD_TIME = X_VARIABLE_LEAD_TIME) OR
        ((RECINFO.VARIABLE_LEAD_TIME IS NULL) AND
        (X_VARIABLE_LEAD_TIME IS NULL))) AND
        ((RECINFO.WIP_SUPPLY_LOCATOR_ID = X_WIP_SUPPLY_LOCATOR_ID) OR
        ((RECINFO.WIP_SUPPLY_LOCATOR_ID IS NULL) AND
        (X_WIP_SUPPLY_LOCATOR_ID IS NULL))) AND
        ((RECINFO.WIP_SUPPLY_TYPE = X_WIP_SUPPLY_TYPE) OR
        ((RECINFO.WIP_SUPPLY_TYPE IS NULL) AND (X_WIP_SUPPLY_TYPE IS NULL))) AND
        ((RECINFO.WIP_SUPPLY_SUBINVENTORY = X_WIP_SUPPLY_SUBINVENTORY) OR
        ((RECINFO.WIP_SUPPLY_SUBINVENTORY IS NULL) AND
        (X_WIP_SUPPLY_SUBINVENTORY IS NULL))) AND
        ((RECINFO.COST_OF_SALES_ACCOUNT = X_COST_OF_SALES_ACCOUNT) OR
        ((RECINFO.COST_OF_SALES_ACCOUNT IS NULL) AND
        (X_COST_OF_SALES_ACCOUNT IS NULL))) AND
        ((RECINFO.SALES_ACCOUNT = X_SALES_ACCOUNT) OR
        ((RECINFO.SALES_ACCOUNT IS NULL) AND (X_SALES_ACCOUNT IS NULL))) AND
        ((RECINFO.DEFAULT_INCLUDE_IN_ROLLUP_FLAG =
        X_DEFAULT_INCLUDE_IN_ROLLUP_FL) OR
        ((RECINFO.DEFAULT_INCLUDE_IN_ROLLUP_FLAG IS NULL) AND
        (X_DEFAULT_INCLUDE_IN_ROLLUP_FL IS NULL))) AND
        ((RECINFO.INVENTORY_ITEM_STATUS_CODE = X_INVENTORY_ITEM_STATUS_CODE) OR
        ((RECINFO.INVENTORY_ITEM_STATUS_CODE IS NULL) AND
        (X_INVENTORY_ITEM_STATUS_CODE IS NULL))) AND
        ((RECINFO.INVENTORY_PLANNING_CODE = X_INVENTORY_PLANNING_CODE) OR
        ((RECINFO.INVENTORY_PLANNING_CODE IS NULL) AND
        (X_INVENTORY_PLANNING_CODE IS NULL))) AND
        ((RECINFO.PLANNER_CODE = X_PLANNER_CODE) OR
        ((RECINFO.PLANNER_CODE IS NULL) AND (X_PLANNER_CODE IS NULL))) AND
        ((RECINFO.PLANNING_MAKE_BUY_CODE = X_PLANNING_MAKE_BUY_CODE) OR
        ((RECINFO.PLANNING_MAKE_BUY_CODE IS NULL) AND
        (X_PLANNING_MAKE_BUY_CODE IS NULL))) AND
        ((RECINFO.FIXED_LOT_MULTIPLIER = X_FIXED_LOT_MULTIPLIER) OR
        ((RECINFO.FIXED_LOT_MULTIPLIER IS NULL) AND
        (X_FIXED_LOT_MULTIPLIER IS NULL))) AND
        ((RECINFO.ROUNDING_CONTROL_TYPE = X_ROUNDING_CONTROL_TYPE) OR
        ((RECINFO.ROUNDING_CONTROL_TYPE IS NULL) AND
        (X_ROUNDING_CONTROL_TYPE IS NULL))) AND
        ((RECINFO.CARRYING_COST = X_CARRYING_COST) OR
        ((RECINFO.CARRYING_COST IS NULL) AND (X_CARRYING_COST IS NULL))) AND
        ((RECINFO.POSTPROCESSING_LEAD_TIME = X_POSTPROCESSING_LEAD_TIME) OR
        ((RECINFO.POSTPROCESSING_LEAD_TIME IS NULL) AND
        (X_POSTPROCESSING_LEAD_TIME IS NULL))) AND
        ((RECINFO.PREPROCESSING_LEAD_TIME = X_PREPROCESSING_LEAD_TIME) OR
        ((RECINFO.PREPROCESSING_LEAD_TIME IS NULL) AND
        (X_PREPROCESSING_LEAD_TIME IS NULL))) AND
        (RECINFO.SUMMARY_FLAG = X_SUMMARY_FLAG) AND
        (RECINFO.ENABLED_FLAG = X_ENABLED_FLAG) AND
        ((RECINFO.START_DATE_ACTIVE = X_START_DATE_ACTIVE) OR
        ((RECINFO.START_DATE_ACTIVE IS NULL) AND
        (X_START_DATE_ACTIVE IS NULL))) AND
        ((RECINFO.END_DATE_ACTIVE = X_END_DATE_ACTIVE) OR
        ((RECINFO.END_DATE_ACTIVE IS NULL) AND (X_END_DATE_ACTIVE IS NULL))) AND
        ((RECINFO.BUYER_ID = X_BUYER_ID) OR
        ((RECINFO.BUYER_ID IS NULL) AND (X_BUYER_ID IS NULL))) AND
        ((RECINFO.ACCOUNTING_RULE_ID = X_ACCOUNTING_RULE_ID) OR
        ((RECINFO.ACCOUNTING_RULE_ID IS NULL) AND
        (X_ACCOUNTING_RULE_ID IS NULL))) AND
        ((RECINFO.INVOICING_RULE_ID = X_INVOICING_RULE_ID) OR
        ((RECINFO.INVOICING_RULE_ID IS NULL) AND
        (X_INVOICING_RULE_ID IS NULL))) AND
        ((RECINFO.OVER_SHIPMENT_TOLERANCE = X_OVER_SHIPMENT_TOLERANCE) OR
        ((RECINFO.OVER_SHIPMENT_TOLERANCE IS NULL) AND
        (X_OVER_SHIPMENT_TOLERANCE IS NULL))) AND
        ((RECINFO.UNDER_SHIPMENT_TOLERANCE = X_UNDER_SHIPMENT_TOLERANCE) OR
        ((RECINFO.UNDER_SHIPMENT_TOLERANCE IS NULL) AND
        (X_UNDER_SHIPMENT_TOLERANCE IS NULL))) AND
        ((RECINFO.OVER_RETURN_TOLERANCE = X_OVER_RETURN_TOLERANCE) OR
        ((RECINFO.OVER_RETURN_TOLERANCE IS NULL) AND
        (X_OVER_RETURN_TOLERANCE IS NULL))) AND
        ((RECINFO.UNDER_RETURN_TOLERANCE = X_UNDER_RETURN_TOLERANCE) OR
        ((RECINFO.UNDER_RETURN_TOLERANCE IS NULL) AND
        (X_UNDER_RETURN_TOLERANCE IS NULL))) AND
        ((RECINFO.EQUIPMENT_TYPE = X_EQUIPMENT_TYPE) OR
        ((RECINFO.EQUIPMENT_TYPE IS NULL) AND (X_EQUIPMENT_TYPE IS NULL))) AND
        ((RECINFO.RECOVERED_PART_DISP_CODE = X_RECOVERED_PART_DISP_CODE) OR
        ((RECINFO.RECOVERED_PART_DISP_CODE IS NULL) AND
        (X_RECOVERED_PART_DISP_CODE IS NULL))) AND
        ((RECINFO.DEFECT_TRACKING_ON_FLAG = X_DEFECT_TRACKING_ON_FLAG) OR
        ((RECINFO.DEFECT_TRACKING_ON_FLAG IS NULL) AND
        (X_DEFECT_TRACKING_ON_FLAG IS NULL))) AND
        ((RECINFO.EVENT_FLAG = X_EVENT_FLAG) OR
        ((RECINFO.EVENT_FLAG IS NULL) AND (X_EVENT_FLAG IS NULL))) AND
        ((RECINFO.ELECTRONIC_FLAG = X_ELECTRONIC_FLAG) OR
        ((RECINFO.ELECTRONIC_FLAG IS NULL) AND (X_ELECTRONIC_FLAG IS NULL))) AND
        ((RECINFO.DOWNLOADABLE_FLAG = X_DOWNLOADABLE_FLAG) OR
        ((RECINFO.DOWNLOADABLE_FLAG IS NULL) AND
        (X_DOWNLOADABLE_FLAG IS NULL))) AND
        ((RECINFO.VOL_DISCOUNT_EXEMPT_FLAG = X_VOL_DISCOUNT_EXEMPT_FLAG) OR
        ((RECINFO.VOL_DISCOUNT_EXEMPT_FLAG IS NULL) AND
        (X_VOL_DISCOUNT_EXEMPT_FLAG IS NULL))) AND
        ((RECINFO.COUPON_EXEMPT_FLAG = X_COUPON_EXEMPT_FLAG) OR
        ((RECINFO.COUPON_EXEMPT_FLAG IS NULL) AND
        (X_COUPON_EXEMPT_FLAG IS NULL))) AND
        ((RECINFO.COMMS_NL_TRACKABLE_FLAG = X_COMMS_NL_TRACKABLE_FLAG) OR
        ((RECINFO.COMMS_NL_TRACKABLE_FLAG IS NULL) AND
        (X_COMMS_NL_TRACKABLE_FLAG IS NULL))) AND
        ((RECINFO.ASSET_CREATION_CODE = X_ASSET_CREATION_CODE) OR
        ((RECINFO.ASSET_CREATION_CODE IS NULL) AND
        (X_ASSET_CREATION_CODE IS NULL))) AND
        ((RECINFO.COMMS_ACTIVATION_REQD_FLAG = X_COMMS_ACTIVATION_REQD_FLAG) OR
        ((RECINFO.COMMS_ACTIVATION_REQD_FLAG IS NULL) AND
        (X_COMMS_ACTIVATION_REQD_FLAG IS NULL))) AND
        ((RECINFO.ORDERABLE_ON_WEB_FLAG = X_ORDERABLE_ON_WEB_FLAG) OR
        ((RECINFO.ORDERABLE_ON_WEB_FLAG IS NULL) AND
        (X_ORDERABLE_ON_WEB_FLAG IS NULL))) AND
        ((RECINFO.BACK_ORDERABLE_FLAG = X_BACK_ORDERABLE_FLAG) OR
        ((RECINFO.BACK_ORDERABLE_FLAG IS NULL) AND
        (X_BACK_ORDERABLE_FLAG IS NULL))) AND
        ((RECINFO.WEB_STATUS = X_WEB_STATUS) OR
        ((RECINFO.WEB_STATUS IS NULL) AND (X_WEB_STATUS IS NULL))) AND
        ((RECINFO.INDIVISIBLE_FLAG = X_INDIVISIBLE_FLAG) OR
        ((RECINFO.INDIVISIBLE_FLAG IS NULL) AND
        (X_INDIVISIBLE_FLAG IS NULL))) AND
        ((RECINFO.DIMENSION_UOM_CODE = X_DIMENSION_UOM_CODE) OR
        ((RECINFO.DIMENSION_UOM_CODE IS NULL) AND
        (X_DIMENSION_UOM_CODE IS NULL))) AND
        ((RECINFO.UNIT_LENGTH = X_UNIT_LENGTH) OR
        ((RECINFO.UNIT_LENGTH IS NULL) AND (X_UNIT_LENGTH IS NULL))) AND
        ((RECINFO.UNIT_WIDTH = X_UNIT_WIDTH) OR
        ((RECINFO.UNIT_WIDTH IS NULL) AND (X_UNIT_WIDTH IS NULL))) AND
        ((RECINFO.UNIT_HEIGHT = X_UNIT_HEIGHT) OR
        ((RECINFO.UNIT_HEIGHT IS NULL) AND (X_UNIT_HEIGHT IS NULL))) AND
        ((RECINFO.BULK_PICKED_FLAG = X_BULK_PICKED_FLAG) OR
        ((RECINFO.BULK_PICKED_FLAG IS NULL) AND
        (X_BULK_PICKED_FLAG IS NULL))) AND
        ((RECINFO.LOT_STATUS_ENABLED = X_LOT_STATUS_ENABLED) OR
        ((RECINFO.LOT_STATUS_ENABLED IS NULL) AND
        (X_LOT_STATUS_ENABLED IS NULL))) AND
        ((RECINFO.DEFAULT_LOT_STATUS_ID = X_DEFAULT_LOT_STATUS_ID) OR
        ((RECINFO.DEFAULT_LOT_STATUS_ID IS NULL) AND
        (X_DEFAULT_LOT_STATUS_ID IS NULL))) AND
        ((RECINFO.SERIAL_STATUS_ENABLED = X_SERIAL_STATUS_ENABLED) OR
        ((RECINFO.SERIAL_STATUS_ENABLED IS NULL) AND
        (X_SERIAL_STATUS_ENABLED IS NULL))) AND
        ((RECINFO.DEFAULT_SERIAL_STATUS_ID = X_DEFAULT_SERIAL_STATUS_ID) OR
        ((RECINFO.DEFAULT_SERIAL_STATUS_ID IS NULL) AND
        (X_DEFAULT_SERIAL_STATUS_ID IS NULL))) AND
        ((RECINFO.LOT_SPLIT_ENABLED = X_LOT_SPLIT_ENABLED) OR
        ((RECINFO.LOT_SPLIT_ENABLED IS NULL) AND
        (X_LOT_SPLIT_ENABLED IS NULL))) AND
        ((RECINFO.LOT_MERGE_ENABLED = X_LOT_MERGE_ENABLED) OR
        ((RECINFO.LOT_MERGE_ENABLED IS NULL) AND
        (X_LOT_MERGE_ENABLED IS NULL))) AND
        ((RECINFO.INVENTORY_CARRY_PENALTY = X_INVENTORY_CARRY_PENALTY) OR
        ((RECINFO.INVENTORY_CARRY_PENALTY IS NULL) AND
        (X_INVENTORY_CARRY_PENALTY IS NULL))) AND
        ((RECINFO.OPERATION_SLACK_PENALTY = X_OPERATION_SLACK_PENALTY) OR
        ((RECINFO.OPERATION_SLACK_PENALTY IS NULL) AND
        (X_OPERATION_SLACK_PENALTY IS NULL))) AND
        ((RECINFO.FINANCING_ALLOWED_FLAG = X_FINANCING_ALLOWED_FLAG) OR
        ((RECINFO.FINANCING_ALLOWED_FLAG IS NULL) AND
        (X_FINANCING_ALLOWED_FLAG IS NULL))) AND
        ((RECINFO.EAM_ITEM_TYPE = X_EAM_ITEM_TYPE) OR
        ((RECINFO.EAM_ITEM_TYPE IS NULL) AND (X_EAM_ITEM_TYPE IS NULL))) AND
        ((RECINFO.EAM_ACTIVITY_TYPE_CODE = X_EAM_ACTIVITY_TYPE_CODE) OR
        ((RECINFO.EAM_ACTIVITY_TYPE_CODE IS NULL) AND
        (X_EAM_ACTIVITY_TYPE_CODE IS NULL))) AND
        ((RECINFO.EAM_ACTIVITY_CAUSE_CODE = X_EAM_ACTIVITY_CAUSE_CODE) OR
        ((RECINFO.EAM_ACTIVITY_CAUSE_CODE IS NULL) AND
        (X_EAM_ACTIVITY_CAUSE_CODE IS NULL))) AND
        ((RECINFO.EAM_ACT_NOTIFICATION_FLAG = X_EAM_ACT_NOTIFICATION_FLAG) OR
        ((RECINFO.EAM_ACT_NOTIFICATION_FLAG IS NULL) AND
        (X_EAM_ACT_NOTIFICATION_FLAG IS NULL))) AND
        ((RECINFO.EAM_ACT_SHUTDOWN_STATUS = X_EAM_ACT_SHUTDOWN_STATUS) OR
        ((RECINFO.EAM_ACT_SHUTDOWN_STATUS IS NULL) AND
        (X_EAM_ACT_SHUTDOWN_STATUS IS NULL))) AND
        ((RECINFO.DUAL_UOM_CONTROL = X_DUAL_UOM_CONTROL) OR
        ((RECINFO.DUAL_UOM_CONTROL IS NULL) AND
        (X_DUAL_UOM_CONTROL IS NULL))) AND
        ((RECINFO.SECONDARY_UOM_CODE = X_SECONDARY_UOM_CODE) OR
        ((RECINFO.SECONDARY_UOM_CODE IS NULL) AND
        (X_SECONDARY_UOM_CODE IS NULL))) AND
        ((RECINFO.DUAL_UOM_DEVIATION_HIGH = X_DUAL_UOM_DEVIATION_HIGH) OR
        ((RECINFO.DUAL_UOM_DEVIATION_HIGH IS NULL) AND
        (X_DUAL_UOM_DEVIATION_HIGH IS NULL))) AND
        ((RECINFO.DUAL_UOM_DEVIATION_LOW = X_DUAL_UOM_DEVIATION_LOW) OR
        ((RECINFO.DUAL_UOM_DEVIATION_LOW IS NULL) AND
        (X_DUAL_UOM_DEVIATION_LOW IS NULL)))
       --
       --    AND (RECINFO.SERVICE_ITEM_FLAG = X_SERVICE_ITEM_FLAG)
       --    AND (RECINFO.VENDOR_WARRANTY_FLAG = X_VENDOR_WARRANTY_FLAG)
       --    AND ( (RECINFO.USAGE_ITEM_FLAG = X_USAGE_ITEM_FLAG)
       --          OR ((RECINFO.USAGE_ITEM_FLAG IS NULL) AND (X_USAGE_ITEM_FLAG IS NULL)) )
       --
        AND ((RECINFO.CONTRACT_ITEM_TYPE_CODE = X_CONTRACT_ITEM_TYPE_CODE) OR
        ((RECINFO.CONTRACT_ITEM_TYPE_CODE IS NULL) AND
        (X_CONTRACT_ITEM_TYPE_CODE IS NULL))) AND
        ((RECINFO.SUBSCRIPTION_DEPEND_FLAG = X_SUBSCRIPTION_DEPEND_FLAG) OR
        ((RECINFO.SUBSCRIPTION_DEPEND_FLAG IS NULL) AND
        (X_SUBSCRIPTION_DEPEND_FLAG IS NULL)))
        AND ((RECINFO.SERV_REQ_ENABLED_CODE = X_SERV_REQ_ENABLED_CODE) OR
        ((RECINFO.SERV_REQ_ENABLED_CODE IS NULL) AND
        (X_SERV_REQ_ENABLED_CODE IS NULL))) AND
        ((RECINFO.SERV_BILLING_ENABLED_FLAG = X_SERV_BILLING_ENABLED_FLAG) OR
        ((RECINFO.SERV_BILLING_ENABLED_FLAG IS NULL) AND
        (X_SERV_BILLING_ENABLED_FLAG IS NULL))) AND
        ((RECINFO.SERV_IMPORTANCE_LEVEL = X_SERV_IMPORTANCE_LEVEL) OR
        ((RECINFO.SERV_IMPORTANCE_LEVEL IS NULL) AND
        (X_SERV_IMPORTANCE_LEVEL IS NULL))) AND
        ((RECINFO.PLANNED_INV_POINT_FLAG = X_PLANNED_INV_POINT_FLAG) OR
        ((RECINFO.PLANNED_INV_POINT_FLAG IS NULL) AND
        (X_PLANNED_INV_POINT_FLAG IS NULL)))
        AND ((RECINFO.LOT_TRANSLATE_ENABLED = X_LOT_TRANSLATE_ENABLED) OR
        ((RECINFO.LOT_TRANSLATE_ENABLED IS NULL) AND
        (X_LOT_TRANSLATE_ENABLED IS NULL))) AND
        (RECINFO.DEFAULT_SO_SOURCE_TYPE = X_DEFAULT_SO_SOURCE_TYPE) AND
        (RECINFO.CREATE_SUPPLY_FLAG = X_CREATE_SUPPLY_FLAG) AND
        ((RECINFO.SUBSTITUTION_WINDOW_CODE = X_SUBSTITUTION_WINDOW_CODE) OR
        ((RECINFO.SUBSTITUTION_WINDOW_CODE IS NULL) AND
        (X_SUBSTITUTION_WINDOW_CODE IS NULL))) AND
        ((RECINFO.SUBSTITUTION_WINDOW_DAYS = X_SUBSTITUTION_WINDOW_DAYS) OR
        ((RECINFO.SUBSTITUTION_WINDOW_DAYS IS NULL) AND
        (X_SUBSTITUTION_WINDOW_DAYS IS NULL)))
        AND ((RECINFO.SEGMENT1 = X_SEGMENT1) OR
        ((RECINFO.SEGMENT1 IS NULL) AND (X_SEGMENT1 IS NULL))) AND
        ((RECINFO.SEGMENT2 = X_SEGMENT2) OR
        ((RECINFO.SEGMENT2 IS NULL) AND (X_SEGMENT2 IS NULL))) AND
        ((RECINFO.SEGMENT3 = X_SEGMENT3) OR
        ((RECINFO.SEGMENT3 IS NULL) AND (X_SEGMENT3 IS NULL))) AND
        ((RECINFO.SEGMENT4 = X_SEGMENT4) OR
        ((RECINFO.SEGMENT4 IS NULL) AND (X_SEGMENT4 IS NULL))) AND
        ((RECINFO.SEGMENT5 = X_SEGMENT5) OR
        ((RECINFO.SEGMENT5 IS NULL) AND (X_SEGMENT5 IS NULL))) AND
        ((RECINFO.SEGMENT6 = X_SEGMENT6) OR
        ((RECINFO.SEGMENT6 IS NULL) AND (X_SEGMENT6 IS NULL))) AND
        ((RECINFO.SEGMENT7 = X_SEGMENT7) OR
        ((RECINFO.SEGMENT7 IS NULL) AND (X_SEGMENT7 IS NULL))) AND
        ((RECINFO.SEGMENT8 = X_SEGMENT8) OR
        ((RECINFO.SEGMENT8 IS NULL) AND (X_SEGMENT8 IS NULL))) AND
        ((RECINFO.SEGMENT9 = X_SEGMENT9) OR
        ((RECINFO.SEGMENT9 IS NULL) AND (X_SEGMENT9 IS NULL))) AND
        ((RECINFO.SEGMENT10 = X_SEGMENT10) OR
        ((RECINFO.SEGMENT10 IS NULL) AND (X_SEGMENT10 IS NULL))) AND
        ((RECINFO.SEGMENT11 = X_SEGMENT11) OR
        ((RECINFO.SEGMENT11 IS NULL) AND (X_SEGMENT11 IS NULL))) AND
        ((RECINFO.SEGMENT12 = X_SEGMENT12) OR
        ((RECINFO.SEGMENT12 IS NULL) AND (X_SEGMENT12 IS NULL))) AND
        ((RECINFO.SEGMENT13 = X_SEGMENT13) OR
        ((RECINFO.SEGMENT13 IS NULL) AND (X_SEGMENT13 IS NULL))) AND
        ((RECINFO.SEGMENT14 = X_SEGMENT14) OR
        ((RECINFO.SEGMENT14 IS NULL) AND (X_SEGMENT14 IS NULL))) AND
        ((RECINFO.SEGMENT15 = X_SEGMENT15) OR
        ((RECINFO.SEGMENT15 IS NULL) AND (X_SEGMENT15 IS NULL))) AND
        ((RECINFO.SEGMENT16 = X_SEGMENT16) OR
        ((RECINFO.SEGMENT16 IS NULL) AND (X_SEGMENT16 IS NULL))) AND
        ((RECINFO.SEGMENT17 = X_SEGMENT17) OR
        ((RECINFO.SEGMENT17 IS NULL) AND (X_SEGMENT17 IS NULL))) AND
        ((RECINFO.SEGMENT18 = X_SEGMENT18) OR
        ((RECINFO.SEGMENT18 IS NULL) AND (X_SEGMENT18 IS NULL))) AND
        ((RECINFO.SEGMENT19 = X_SEGMENT19) OR
        ((RECINFO.SEGMENT19 IS NULL) AND (X_SEGMENT19 IS NULL))) AND
        ((RECINFO.SEGMENT20 = X_SEGMENT20) OR
        ((RECINFO.SEGMENT20 IS NULL) AND (X_SEGMENT20 IS NULL))) AND
        ((RECINFO.ATTRIBUTE_CATEGORY = X_ATTRIBUTE_CATEGORY) OR
        ((RECINFO.ATTRIBUTE_CATEGORY IS NULL) AND
        (X_ATTRIBUTE_CATEGORY IS NULL))) AND
        ((RECINFO.ATTRIBUTE1 = X_ATTRIBUTE1) OR
        ((RECINFO.ATTRIBUTE1 IS NULL) AND (X_ATTRIBUTE1 IS NULL))) AND
        ((RECINFO.ATTRIBUTE2 = X_ATTRIBUTE2) OR
        ((RECINFO.ATTRIBUTE2 IS NULL) AND (X_ATTRIBUTE2 IS NULL))) AND
        ((RECINFO.ATTRIBUTE3 = X_ATTRIBUTE3) OR
        ((RECINFO.ATTRIBUTE3 IS NULL) AND (X_ATTRIBUTE3 IS NULL))) AND
        ((RECINFO.ATTRIBUTE4 = X_ATTRIBUTE4) OR
        ((RECINFO.ATTRIBUTE4 IS NULL) AND (X_ATTRIBUTE4 IS NULL))) AND
        ((RECINFO.ATTRIBUTE5 = X_ATTRIBUTE5) OR
        ((RECINFO.ATTRIBUTE5 IS NULL) AND (X_ATTRIBUTE5 IS NULL)))
       \*AND ((RECINFO.PROGRAM_UPDATE_DATE = X_PROGRAM_UPDATE_DATE)
                                                                                                      OR ((RECINFO.PROGRAM_UPDATE_DATE IS NULL) AND (X_PROGRAM_UPDATE_DATE IS NULL)))*\
       \*AND ((RECINFO.OBJECT_VERSION_NUMBER = X_OBJECT_VERSION_NUMBER)
                                                                                                      OR ((RECINFO.OBJECT_VERSION_NUMBER IS NULL) AND (X_OBJECT_VERSION_NUMBER IS NULL)))    *\
        AND ((RECINFO.TRACKING_QUANTITY_IND = X_TRACKING_QUANTITY_IND) OR
        ((RECINFO.TRACKING_QUANTITY_IND IS NULL) AND
        (X_TRACKING_QUANTITY_IND IS NULL)))
        AND ((RECINFO.ONT_PRICING_QTY_SOURCE = X_ONT_PRICING_QTY_SOURCE) OR
        ((RECINFO.ONT_PRICING_QTY_SOURCE IS NULL) AND
        (X_ONT_PRICING_QTY_SOURCE IS NULL)))
        AND
        ((RECINFO.CONSIGNED_FLAG = X_CONSIGNED_FLAG) OR
        ((RECINFO.CONSIGNED_FLAG IS NULL) AND (X_CONSIGNED_FLAG IS NULL)))
        AND ((RECINFO.ASN_AUTOEXPIRE_FLAG = X_ASN_AUTOEXPIRE_FLAG) OR
        ((RECINFO.ASN_AUTOEXPIRE_FLAG IS NULL) AND
        (X_ASN_AUTOEXPIRE_FLAG IS NULL)))
        AND ((RECINFO.VMI_FORECAST_TYPE = X_VMI_FORECAST_TYPE) OR
        ((RECINFO.VMI_FORECAST_TYPE IS NULL) AND
        (X_VMI_FORECAST_TYPE IS NULL)))
        AND ((RECINFO.EXCLUDE_FROM_BUDGET_FLAG = X_EXCLUDE_FROM_BUDGET_FLAG) OR
        ((RECINFO.EXCLUDE_FROM_BUDGET_FLAG IS NULL) AND
        (X_EXCLUDE_FROM_BUDGET_FLAG IS NULL)))
        AND ((RECINFO.DRP_PLANNED_FLAG = X_DRP_PLANNED_FLAG) OR
        ((RECINFO.DRP_PLANNED_FLAG IS NULL) AND
        (X_DRP_PLANNED_FLAG IS NULL)))
        AND ((RECINFO.CRITICAL_COMPONENT_FLAG = X_CRITICAL_COMPONENT_FLAG) OR
        ((RECINFO.CRITICAL_COMPONENT_FLAG IS NULL) AND
        (X_CRITICAL_COMPONENT_FLAG IS NULL)))
        AND ((RECINFO.CONTINOUS_TRANSFER = X_CONTINOUS_TRANSFER) OR
        ((RECINFO.CONTINOUS_TRANSFER IS NULL) AND
        (X_CONTINOUS_TRANSFER IS NULL)))
        AND ((RECINFO.CONVERGENCE = X_CONVERGENCE) OR
        ((RECINFO.CONVERGENCE IS NULL) AND (X_CONVERGENCE IS NULL)))
        AND ((RECINFO.DIVERGENCE = X_DIVERGENCE) OR
        ((RECINFO.DIVERGENCE IS NULL) AND (X_DIVERGENCE IS NULL)))) THEN
      NULL;
    ELSE
      FND_MESSAGE.SET_NAME('FND', 'FORM_RECORD_CHANGED');
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
    FOR TLINFO IN C1 LOOP
      IF (TLINFO.BASELANG = 'Y') THEN
        IF (((TLINFO.DESCRIPTION = X_DESCRIPTION) OR
           ((TLINFO.DESCRIPTION IS NULL) AND (X_DESCRIPTION IS NULL))) AND
           ((TLINFO.LONG_DESCRIPTION = X_LONG_DESCRIPTION) OR
           ((TLINFO.LONG_DESCRIPTION IS NULL) AND
           (X_LONG_DESCRIPTION IS NULL)))) THEN
          NULL;
        ELSE
          FND_MESSAGE.SET_NAME('FND', 'FORM_RECORD_CHANGED');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END LOOP;
    IF (L_ORG_ID = GET_MASTER_ORG_ID(L_ORG_ID)) THEN
      -- LOCK ORGANIZATION ITEMS
      --
      INV_ITEM_PVT.LOCK_ORG_ITEMS(P_ITEM_ID       => L_ITEM_ID,
                                  P_ORG_ID        => L_ORG_ID,
                                  P_LOCK_MASTER   => FND_API.G_TRUE,
                                  P_LOCK_ORGS     => FND_API.G_TRUE,
                                  X_RETURN_STATUS => L_RETURN_STATUS);
    END IF;
    RETURN;
  END LOCK_ROW;
  -- ------------------ UPDATE_ROW -------------------
  PROCEDURE UPDATE_ROW(X_INVENTORY_ITEM_ID IN NUMBER,
                       X_ORGANIZATION_ID   IN NUMBER,
                       --  X_MASTER_ORG_ID   IN NUMBER,
                       X_DESCRIPTION      IN VARCHAR2,
                       X_LONG_DESCRIPTION IN VARCHAR2,
                       X_PRIMARY_UOM_CODE IN VARCHAR2,
                       --  X_PRIMARY_UNIT_OF_MEASURE IN VARCHAR2,
                       X_ALLOWED_UNITS_LOOKUP_CODE    IN NUMBER,
                       X_OVERCOMPLETION_TOLERANCE_TYP IN NUMBER,
                       X_OVERCOMPLETION_TOLERANCE_VAL IN NUMBER,
                       X_EFFECTIVITY_CONTROL          IN NUMBER,
                       X_CHECK_SHORTAGES_FLAG         IN VARCHAR2,
                       X_FULL_LEAD_TIME               IN NUMBER,
                       X_ORDER_COST                   IN NUMBER,
                       X_MRP_SAFETY_STOCK_PERCENT     IN NUMBER,
                       X_MRP_SAFETY_STOCK_CODE        IN NUMBER,
                       X_MIN_MINMAX_QUANTITY          IN NUMBER,
                       X_MAX_MINMAX_QUANTITY          IN NUMBER,
                       X_MINIMUM_ORDER_QUANTITY       IN NUMBER,
                       X_FIXED_ORDER_QUANTITY         IN NUMBER,
                       X_FIXED_DAYS_SUPPLY            IN NUMBER,
                       X_MAXIMUM_ORDER_QUANTITY       IN NUMBER,
                       X_ATP_RULE_ID                  IN NUMBER,
                       X_PICKING_RULE_ID              IN NUMBER,
                       X_RESERVABLE_TYPE              IN NUMBER,
                       X_POSITIVE_MEASUREMENT_ERROR   IN NUMBER,
                       X_NEGATIVE_MEASUREMENT_ERROR   IN NUMBER,
                       X_ENGINEERING_ECN_CODE         IN VARCHAR2,
                       X_ENGINEERING_ITEM_ID          IN NUMBER,
                       X_ENGINEERING_DATE             IN DATE,
                       X_SERVICE_STARTING_DELAY       IN NUMBER,
                       X_SERVICEABLE_COMPONENT_FLAG   IN VARCHAR2,
                       X_SERVICEABLE_PRODUCT_FLAG     IN VARCHAR2,
                       --  X_BASE_WARRANTY_SERVICE_ID IN NUMBER,
                       X_PAYMENT_TERMS_ID            IN NUMBER,
                       X_PREVENTIVE_MAINTENANCE_FLAG IN VARCHAR2,
                       --  X_PRIMARY_SPECIALIST_ID IN NUMBER,
                       --  X_SECONDARY_SPECIALIST_ID IN NUMBER,
                       --  X_SERVICEABLE_ITEM_CLASS_ID IN NUMBER,
                       --  X_TIME_BILLABLE_FLAG IN VARCHAR2,
                       X_MATERIAL_BILLABLE_FLAG IN VARCHAR2,
                       --  X_EXPENSE_BILLABLE_FLAG IN VARCHAR2,
                       X_PRORATE_SERVICE_FLAG         IN VARCHAR2,
                       X_COVERAGE_SCHEDULE_ID         IN NUMBER,
                       X_SERVICE_DURATION_PERIOD_CODE IN VARCHAR2,
                       X_SERVICE_DURATION             IN NUMBER,
                       --  X_WARRANTY_VENDOR_ID IN NUMBER,
                       --  X_MAX_WARRANTY_AMOUNT IN NUMBER,
                       --  X_RESPONSE_TIME_PERIOD_CODE IN VARCHAR2,
                       --  X_RESPONSE_TIME_VALUE IN NUMBER,
                       --  X_NEW_REVISION_CODE IN VARCHAR2,
                       X_INVOICEABLE_ITEM_FLAG        IN VARCHAR2,
                       X_TAX_CODE                     IN VARCHAR2,
                       X_INVOICE_ENABLED_FLAG         IN VARCHAR2,
                       X_MUST_USE_APPROVED_VENDOR_FLA IN VARCHAR2,
                       --  X_REQUEST_ID IN NUMBER,
                       X_OUTSIDE_OPERATION_FLAG       IN VARCHAR2,
                       X_OUTSIDE_OPERATION_UOM_TYPE   IN VARCHAR2,
                       X_SAFETY_STOCK_BUCKET_DAYS     IN NUMBER,
                       X_AUTO_REDUCE_MPS              IN NUMBER,
                       X_COSTING_ENABLED_FLAG         IN VARCHAR2,
                       X_AUTO_CREATED_CONFIG_FLAG     IN VARCHAR2,
                       X_CYCLE_COUNT_ENABLED_FLAG     IN VARCHAR2,
                       X_ITEM_TYPE                    IN VARCHAR2,
                       X_MODEL_CONFIG_CLAUSE_NAME     IN VARCHAR2,
                       X_SHIP_MODEL_COMPLETE_FLAG     IN VARCHAR2,
                       X_MRP_PLANNING_CODE            IN NUMBER,
                       X_RETURN_INSPECTION_REQUIREMEN IN NUMBER,
                       X_ATO_FORECAST_CONTROL         IN NUMBER,
                       X_RELEASE_TIME_FENCE_CODE      IN NUMBER,
                       X_RELEASE_TIME_FENCE_DAYS      IN NUMBER,
                       X_CONTAINER_ITEM_FLAG          IN VARCHAR2,
                       X_VEHICLE_ITEM_FLAG            IN VARCHAR2,
                       X_MAXIMUM_LOAD_WEIGHT          IN NUMBER,
                       X_MINIMUM_FILL_PERCENT         IN NUMBER,
                       X_CONTAINER_TYPE_CODE          IN VARCHAR2,
                       X_INTERNAL_VOLUME              IN NUMBER,
                       --  X_WH_UPDATE_DATE IN DATE,
                       X_PRODUCT_FAMILY_ITEM_ID       IN NUMBER,
                       X_GLOBAL_ATTRIBUTE_CATEGORY    IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE1            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE2            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE3            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE4            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE5            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE6            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE7            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE8            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE9            IN VARCHAR2,
                       X_GLOBAL_ATTRIBUTE10           IN VARCHAR2,
                       X_PURCHASING_TAX_CODE          IN VARCHAR2,
                       X_ATTRIBUTE6                   IN VARCHAR2,
                       X_ATTRIBUTE7                   IN VARCHAR2,
                       X_ATTRIBUTE8                   IN VARCHAR2,
                       X_ATTRIBUTE9                   IN VARCHAR2,
                       X_ATTRIBUTE10                  IN VARCHAR2,
                       X_ATTRIBUTE11                  IN VARCHAR2,
                       X_ATTRIBUTE12                  IN VARCHAR2,
                       X_ATTRIBUTE13                  IN VARCHAR2,
                       X_ATTRIBUTE14                  IN VARCHAR2,
                       X_ATTRIBUTE15                  IN VARCHAR2,
                       X_PURCHASING_ITEM_FLAG         IN VARCHAR2,
                       X_SHIPPABLE_ITEM_FLAG          IN VARCHAR2,
                       X_CUSTOMER_ORDER_FLAG          IN VARCHAR2,
                       X_INTERNAL_ORDER_FLAG          IN VARCHAR2,
                       X_INVENTORY_ITEM_FLAG          IN VARCHAR2,
                       X_ENG_ITEM_FLAG                IN VARCHAR2,
                       X_INVENTORY_ASSET_FLAG         IN VARCHAR2,
                       X_PURCHASING_ENABLED_FLAG      IN VARCHAR2,
                       X_CUSTOMER_ORDER_ENABLED_FLAG  IN VARCHAR2,
                       X_INTERNAL_ORDER_ENABLED_FLAG  IN VARCHAR2,
                       X_SO_TRANSACTIONS_FLAG         IN VARCHAR2,
                       X_MTL_TRANSACTIONS_ENABLED_FLA IN VARCHAR2,
                       X_STOCK_ENABLED_FLAG           IN VARCHAR2,
                       X_BOM_ENABLED_FLAG             IN VARCHAR2,
                       X_BUILD_IN_WIP_FLAG            IN VARCHAR2,
                       X_REVISION_QTY_CONTROL_CODE    IN NUMBER,
                       X_ITEM_CATALOG_GROUP_ID        IN NUMBER,
                       X_CATALOG_STATUS_FLAG          IN VARCHAR2,
                       X_RETURNABLE_FLAG              IN VARCHAR2,
                       X_DEFAULT_SHIPPING_ORG         IN NUMBER,
                       X_COLLATERAL_FLAG              IN VARCHAR2,
                       X_TAXABLE_FLAG                 IN VARCHAR2,
                       X_QTY_RCV_EXCEPTION_CODE       IN VARCHAR2,
                       X_ALLOW_ITEM_DESC_UPDATE_FLAG  IN VARCHAR2,
                       X_INSPECTION_REQUIRED_FLAG     IN VARCHAR2,
                       X_RECEIPT_REQUIRED_FLAG        IN VARCHAR2,
                       X_MARKET_PRICE                 IN NUMBER,
                       X_HAZARD_CLASS_ID              IN NUMBER,
                       X_RFQ_REQUIRED_FLAG            IN VARCHAR2,
                       X_QTY_RCV_TOLERANCE            IN NUMBER,
                       X_LIST_PRICE_PER_UNIT          IN NUMBER,
                       X_UN_NUMBER_ID                 IN NUMBER,
                       X_PRICE_TOLERANCE_PERCENT      IN NUMBER,
                       X_ASSET_CATEGORY_ID            IN NUMBER,
                       X_ROUNDING_FACTOR              IN NUMBER,
                       X_UNIT_OF_ISSUE                IN VARCHAR2,
                       X_ENFORCE_SHIP_TO_LOCATION_COD IN VARCHAR2,
                       X_ALLOW_SUBSTITUTE_RECEIPTS_FL IN VARCHAR2,
                       X_ALLOW_UNORDERED_RECEIPTS_FLA IN VARCHAR2,
                       X_ALLOW_EXPRESS_DELIVERY_FLAG  IN VARCHAR2,
                       X_DAYS_EARLY_RECEIPT_ALLOWED   IN NUMBER,
                       X_DAYS_LATE_RECEIPT_ALLOWED    IN NUMBER,
                       X_RECEIPT_DAYS_EXCEPTION_CODE  IN VARCHAR2,
                       X_RECEIVING_ROUTING_ID         IN NUMBER,
                       X_INVOICE_CLOSE_TOLERANCE      IN NUMBER,
                       X_RECEIVE_CLOSE_TOLERANCE      IN NUMBER,
                       X_AUTO_LOT_ALPHA_PREFIX        IN VARCHAR2,
                       X_START_AUTO_LOT_NUMBER        IN VARCHAR2,
                       X_LOT_CONTROL_CODE             IN NUMBER,
                       X_SHELF_LIFE_CODE              IN NUMBER,
                       X_SHELF_LIFE_DAYS              IN NUMBER,
                       X_SERIAL_NUMBER_CONTROL_CODE   IN NUMBER,
                       X_START_AUTO_SERIAL_NUMBER     IN VARCHAR2,
                       X_AUTO_SERIAL_ALPHA_PREFIX     IN VARCHAR2,
                       X_SOURCE_TYPE                  IN NUMBER,
                       X_SOURCE_ORGANIZATION_ID       IN NUMBER,
                       X_SOURCE_SUBINVENTORY          IN VARCHAR2,
                       X_EXPENSE_ACCOUNT              IN NUMBER,
                       X_ENCUMBRANCE_ACCOUNT          IN NUMBER,
                       X_RESTRICT_SUBINVENTORIES_CODE IN NUMBER,
                       X_UNIT_WEIGHT                  IN NUMBER,
                       X_WEIGHT_UOM_CODE              IN VARCHAR2,
                       X_VOLUME_UOM_CODE              IN VARCHAR2,
                       X_UNIT_VOLUME                  IN NUMBER,
                       X_RESTRICT_LOCATORS_CODE       IN NUMBER,
                       X_LOCATION_CONTROL_CODE        IN NUMBER,
                       X_SHRINKAGE_RATE               IN NUMBER,
                       X_ACCEPTABLE_EARLY_DAYS        IN NUMBER,
                       X_PLANNING_TIME_FENCE_CODE     IN NUMBER,
                       X_DEMAND_TIME_FENCE_CODE       IN NUMBER,
                       X_LEAD_TIME_LOT_SIZE           IN NUMBER,
                       X_STD_LOT_SIZE                 IN NUMBER,
                       X_CUM_MANUFACTURING_LEAD_TIME  IN NUMBER,
                       X_OVERRUN_PERCENTAGE           IN NUMBER,
                       X_MRP_CALCULATE_ATP_FLAG       IN VARCHAR2,
                       X_ACCEPTABLE_RATE_INCREASE     IN NUMBER,
                       X_ACCEPTABLE_RATE_DECREASE     IN NUMBER,
                       X_CUMULATIVE_TOTAL_LEAD_TIME   IN NUMBER,
                       X_PLANNING_TIME_FENCE_DAYS     IN NUMBER,
                       X_DEMAND_TIME_FENCE_DAYS       IN NUMBER,
                       X_END_ASSEMBLY_PEGGING_FLAG    IN VARCHAR2,
                       X_REPETITIVE_PLANNING_FLAG     IN VARCHAR2,
                       X_PLANNING_EXCEPTION_SET       IN VARCHAR2,
                       X_BOM_ITEM_TYPE                IN NUMBER,
                       X_PICK_COMPONENTS_FLAG         IN VARCHAR2,
                       X_REPLENISH_TO_ORDER_FLAG      IN VARCHAR2,
                       X_BASE_ITEM_ID                 IN NUMBER,
                       X_ATP_COMPONENTS_FLAG          IN VARCHAR2,
                       X_ATP_FLAG                     IN VARCHAR2,
                       X_FIXED_LEAD_TIME              IN NUMBER,
                       X_VARIABLE_LEAD_TIME           IN NUMBER,
                       X_WIP_SUPPLY_LOCATOR_ID        IN NUMBER,
                       X_WIP_SUPPLY_TYPE              IN NUMBER,
                       X_WIP_SUPPLY_SUBINVENTORY      IN VARCHAR2,
                       X_COST_OF_SALES_ACCOUNT        IN NUMBER,
                       X_SALES_ACCOUNT                IN NUMBER,
                       X_DEFAULT_INCLUDE_IN_ROLLUP_FL IN VARCHAR2,
                       X_INVENTORY_ITEM_STATUS_CODE   IN VARCHAR2,
                       X_INVENTORY_PLANNING_CODE      IN NUMBER,
                       X_PLANNER_CODE                 IN VARCHAR2,
                       X_PLANNING_MAKE_BUY_CODE       IN NUMBER,
                       X_FIXED_LOT_MULTIPLIER         IN NUMBER,
                       X_ROUNDING_CONTROL_TYPE        IN NUMBER,
                       X_CARRYING_COST                IN NUMBER,
                       X_POSTPROCESSING_LEAD_TIME     IN NUMBER,
                       X_PREPROCESSING_LEAD_TIME      IN NUMBER,
                       X_SUMMARY_FLAG                 IN VARCHAR2,
                       X_ENABLED_FLAG                 IN VARCHAR2,
                       X_START_DATE_ACTIVE            IN DATE,
                       X_END_DATE_ACTIVE              IN DATE,
                       X_BUYER_ID                     IN NUMBER,
                       X_ACCOUNTING_RULE_ID           IN NUMBER,
                       X_INVOICING_RULE_ID            IN NUMBER,
                       X_OVER_SHIPMENT_TOLERANCE      IN NUMBER,
                       X_UNDER_SHIPMENT_TOLERANCE     IN NUMBER,
                       X_OVER_RETURN_TOLERANCE        IN NUMBER,
                       X_UNDER_RETURN_TOLERANCE       IN NUMBER,
                       X_EQUIPMENT_TYPE               IN NUMBER,
                       X_RECOVERED_PART_DISP_CODE     IN VARCHAR2,
                       X_DEFECT_TRACKING_ON_FLAG      IN VARCHAR2,
                       X_EVENT_FLAG                   IN VARCHAR2,
                       X_ELECTRONIC_FLAG              IN VARCHAR2,
                       X_DOWNLOADABLE_FLAG            IN VARCHAR2,
                       X_VOL_DISCOUNT_EXEMPT_FLAG     IN VARCHAR2,
                       X_COUPON_EXEMPT_FLAG           IN VARCHAR2,
                       X_COMMS_NL_TRACKABLE_FLAG      IN VARCHAR2,
                       X_ASSET_CREATION_CODE          IN VARCHAR2,
                       X_COMMS_ACTIVATION_REQD_FLAG   IN VARCHAR2,
                       X_ORDERABLE_ON_WEB_FLAG        IN VARCHAR2,
                       X_BACK_ORDERABLE_FLAG          IN VARCHAR2,
                       X_WEB_STATUS                   IN VARCHAR2,
                       X_INDIVISIBLE_FLAG             IN VARCHAR2,
                       X_DIMENSION_UOM_CODE           IN VARCHAR2,
                       X_UNIT_LENGTH                  IN NUMBER,
                       X_UNIT_WIDTH                   IN NUMBER,
                       X_UNIT_HEIGHT                  IN NUMBER,
                       X_BULK_PICKED_FLAG             IN VARCHAR2,
                       X_LOT_STATUS_ENABLED           IN VARCHAR2,
                       X_DEFAULT_LOT_STATUS_ID        IN NUMBER,
                       X_SERIAL_STATUS_ENABLED        IN VARCHAR2,
                       X_DEFAULT_SERIAL_STATUS_ID     IN NUMBER,
                       X_LOT_SPLIT_ENABLED            IN VARCHAR2,
                       X_LOT_MERGE_ENABLED            IN VARCHAR2,
                       X_INVENTORY_CARRY_PENALTY      IN NUMBER,
                       X_OPERATION_SLACK_PENALTY      IN NUMBER,
                       X_FINANCING_ALLOWED_FLAG       IN VARCHAR2,
                       X_EAM_ITEM_TYPE                IN NUMBER,
                       X_EAM_ACTIVITY_TYPE_CODE       IN VARCHAR2,
                       X_EAM_ACTIVITY_CAUSE_CODE      IN VARCHAR2,
                       X_EAM_ACT_NOTIFICATION_FLAG    IN VARCHAR2,
                       X_EAM_ACT_SHUTDOWN_STATUS      IN VARCHAR2,
                       X_DUAL_UOM_CONTROL             IN NUMBER,
                       X_SECONDARY_UOM_CODE           IN VARCHAR2,
                       X_DUAL_UOM_DEVIATION_HIGH      IN NUMBER,
                       X_DUAL_UOM_DEVIATION_LOW       IN NUMBER
                       --,  X_SERVICE_ITEM_FLAG          IN   VARCHAR2
                       --,  X_VENDOR_WARRANTY_FLAG       IN   VARCHAR2
                       --,  X_USAGE_ITEM_FLAG            IN   VARCHAR2
                      ,
                       X_CONTRACT_ITEM_TYPE_CODE   IN VARCHAR2,
                       X_SUBSCRIPTION_DEPEND_FLAG  IN VARCHAR2,
                       X_SERV_REQ_ENABLED_CODE     IN VARCHAR2,
                       X_SERV_BILLING_ENABLED_FLAG IN VARCHAR2,
                       X_SERV_IMPORTANCE_LEVEL     IN NUMBER,
                       X_PLANNED_INV_POINT_FLAG    IN VARCHAR2,
                       X_LOT_TRANSLATE_ENABLED     IN VARCHAR2,
                       X_DEFAULT_SO_SOURCE_TYPE    IN VARCHAR2,
                       X_CREATE_SUPPLY_FLAG        IN VARCHAR2,
                       X_SUBSTITUTION_WINDOW_CODE  IN NUMBER,
                       X_SUBSTITUTION_WINDOW_DAYS  IN NUMBER,
                       X_SEGMENT1                  IN VARCHAR2,
                       X_SEGMENT2                  IN VARCHAR2,
                       X_SEGMENT3                  IN VARCHAR2,
                       X_SEGMENT4                  IN VARCHAR2,
                       X_SEGMENT5                  IN VARCHAR2,
                       X_SEGMENT6                  IN VARCHAR2,
                       X_SEGMENT7                  IN VARCHAR2,
                       X_SEGMENT8                  IN VARCHAR2,
                       X_SEGMENT9                  IN VARCHAR2,
                       X_SEGMENT10                 IN VARCHAR2,
                       X_SEGMENT11                 IN VARCHAR2,
                       X_SEGMENT12                 IN VARCHAR2,
                       X_SEGMENT13                 IN VARCHAR2,
                       X_SEGMENT14                 IN VARCHAR2,
                       X_SEGMENT15                 IN VARCHAR2,
                       X_SEGMENT16                 IN VARCHAR2,
                       X_SEGMENT17                 IN VARCHAR2,
                       X_SEGMENT18                 IN VARCHAR2,
                       X_SEGMENT19                 IN VARCHAR2,
                       X_SEGMENT20                 IN VARCHAR2,
                       X_ATTRIBUTE_CATEGORY        IN VARCHAR2,
                       X_ATTRIBUTE1                IN VARCHAR2,
                       X_ATTRIBUTE2                IN VARCHAR2,
                       X_ATTRIBUTE3                IN VARCHAR2,
                       X_ATTRIBUTE4                IN VARCHAR2,
                       X_ATTRIBUTE5                IN VARCHAR2,
                       X_LAST_UPDATE_DATE          IN DATE,
                       X_LAST_UPDATED_BY           IN NUMBER,
                       X_LAST_UPDATE_LOGIN         IN NUMBER,
                       --X_PROGRAM_UPDATE_DATE IN DATE,
                       -- X_OBJECT_VERSION_NUMBER IN NUMBER,
                       X_TRACKING_QUANTITY_IND    IN VARCHAR2,
                       X_ONT_PRICING_QTY_SOURCE   IN VARCHAR2,
                       X_CONSIGNED_FLAG           IN NUMBER,
                       X_ASN_AUTOEXPIRE_FLAG      IN NUMBER,
                       X_VMI_FORECAST_TYPE        IN NUMBER,
                       X_EXCLUDE_FROM_BUDGET_FLAG IN NUMBER,
                       X_DRP_PLANNED_FLAG         IN NUMBER,
                       X_CRITICAL_COMPONENT_FLAG  IN NUMBER,
                       X_CONTINOUS_TRANSFER       IN NUMBER,
                       X_CONVERGENCE              IN NUMBER,
                       X_DIVERGENCE               IN NUMBER) IS
    L_ITEM_REC INV_ITEM_API.ITEM_REC_TYPE;
    L_INVENTORY_ITEM_ID NUMBER := X_INVENTORY_ITEM_ID;
    L_ORGANIZATION_ID   NUMBER := X_ORGANIZATION_ID;
    L_RETURN_STATUS VARCHAR2(1);
    L_MSG_COUNT     NUMBER;
    L_MSG_DATA      VARCHAR2(2000);
    -- VARIABLES HOLDING DERIVED ATTRIBUTE VALUES.
    L_PRIMARY_UNIT_OF_MEASURE VARCHAR2(25);
  BEGIN
    -- PRIMARY_UNIT_OF_MEASURE LOOKUP
    SELECT UNIT_OF_MEASURE
      INTO L_PRIMARY_UNIT_OF_MEASURE
      FROM MTL_UNITS_OF_MEASURE_VL
     WHERE UOM_CODE = X_PRIMARY_UOM_CODE;
    -- COPY ITEM ATTRIBUTE VALUES INTO THE API RECORD VARIABLE.
    L_ITEM_REC.INVENTORY_ITEM_ID := X_INVENTORY_ITEM_ID;
    L_ITEM_REC.ORGANIZATION_ID   := X_ORGANIZATION_ID;
    \*
      L_ITEM_REC.DESCRIPTION := DECODE(L_INSTALLED_FLAG, 'B', X_DESCRIPTION, L_ITEM_REC.DESCRIPTION) ;
    *\
    L_ITEM_REC.DESCRIPTION      := X_DESCRIPTION;
    L_ITEM_REC.LONG_DESCRIPTION := X_LONG_DESCRIPTION;
    L_ITEM_REC.PRIMARY_UOM_CODE := X_PRIMARY_UOM_CODE;
    -- DERIVED ATTRIBUTE
    L_ITEM_REC.PRIMARY_UNIT_OF_MEASURE := L_PRIMARY_UNIT_OF_MEASURE;
    --
    L_ITEM_REC.ALLOWED_UNITS_LOOKUP_CODE      := X_ALLOWED_UNITS_LOOKUP_CODE;
    L_ITEM_REC.OVERCOMPLETION_TOLERANCE_TYPE  := X_OVERCOMPLETION_TOLERANCE_TYP;
    L_ITEM_REC.OVERCOMPLETION_TOLERANCE_VALUE := X_OVERCOMPLETION_TOLERANCE_VAL;
    L_ITEM_REC.EFFECTIVITY_CONTROL            := X_EFFECTIVITY_CONTROL;
    L_ITEM_REC.CHECK_SHORTAGES_FLAG           := X_CHECK_SHORTAGES_FLAG;
    L_ITEM_REC.FULL_LEAD_TIME                 := X_FULL_LEAD_TIME;
    L_ITEM_REC.ORDER_COST                     := X_ORDER_COST;
    L_ITEM_REC.MRP_SAFETY_STOCK_PERCENT       := X_MRP_SAFETY_STOCK_PERCENT;
    L_ITEM_REC.MRP_SAFETY_STOCK_CODE          := X_MRP_SAFETY_STOCK_CODE;
    L_ITEM_REC.MIN_MINMAX_QUANTITY            := X_MIN_MINMAX_QUANTITY;
    L_ITEM_REC.MAX_MINMAX_QUANTITY            := X_MAX_MINMAX_QUANTITY;
    L_ITEM_REC.MINIMUM_ORDER_QUANTITY         := X_MINIMUM_ORDER_QUANTITY;
    L_ITEM_REC.FIXED_ORDER_QUANTITY           := X_FIXED_ORDER_QUANTITY;
    L_ITEM_REC.FIXED_DAYS_SUPPLY              := X_FIXED_DAYS_SUPPLY;
    L_ITEM_REC.MAXIMUM_ORDER_QUANTITY         := X_MAXIMUM_ORDER_QUANTITY;
    L_ITEM_REC.ATP_RULE_ID                    := X_ATP_RULE_ID;
    L_ITEM_REC.PICKING_RULE_ID                := X_PICKING_RULE_ID;
    L_ITEM_REC.RESERVABLE_TYPE                := X_RESERVABLE_TYPE;
    L_ITEM_REC.POSITIVE_MEASUREMENT_ERROR     := X_POSITIVE_MEASUREMENT_ERROR;
    L_ITEM_REC.NEGATIVE_MEASUREMENT_ERROR     := X_NEGATIVE_MEASUREMENT_ERROR;
    L_ITEM_REC.ENGINEERING_ECN_CODE           := X_ENGINEERING_ECN_CODE;
    L_ITEM_REC.ENGINEERING_ITEM_ID            := X_ENGINEERING_ITEM_ID;
    L_ITEM_REC.ENGINEERING_DATE               := X_ENGINEERING_DATE;
    L_ITEM_REC.SERVICE_STARTING_DELAY         := X_SERVICE_STARTING_DELAY;
    L_ITEM_REC.SERVICEABLE_COMPONENT_FLAG     := X_SERVICEABLE_COMPONENT_FLAG;
    L_ITEM_REC.SERVICEABLE_PRODUCT_FLAG       := X_SERVICEABLE_PRODUCT_FLAG;
    --  L_ITEM_REC.BASE_WARRANTY_SERVICE_ID := X_BASE_WARRANTY_SERVICE_ID ;
    L_ITEM_REC.PAYMENT_TERMS_ID            := X_PAYMENT_TERMS_ID;
    L_ITEM_REC.PREVENTIVE_MAINTENANCE_FLAG := X_PREVENTIVE_MAINTENANCE_FLAG;
    --  L_ITEM_REC.PRIMARY_SPECIALIST_ID := X_PRIMARY_SPECIALIST_ID ;
    --  L_ITEM_REC.SECONDARY_SPECIALIST_ID := X_SECONDARY_SPECIALIST_ID ;
    --  L_ITEM_REC.SERVICEABLE_ITEM_CLASS_ID := X_SERVICEABLE_ITEM_CLASS_ID ;
    --  L_ITEM_REC.TIME_BILLABLE_FLAG := X_TIME_BILLABLE_FLAG ;
    L_ITEM_REC.MATERIAL_BILLABLE_FLAG := X_MATERIAL_BILLABLE_FLAG;
    --  L_ITEM_REC.EXPENSE_BILLABLE_FLAG := X_EXPENSE_BILLABLE_FLAG ;
    L_ITEM_REC.PRORATE_SERVICE_FLAG         := X_PRORATE_SERVICE_FLAG;
    L_ITEM_REC.COVERAGE_SCHEDULE_ID         := X_COVERAGE_SCHEDULE_ID;
    L_ITEM_REC.SERVICE_DURATION_PERIOD_CODE := X_SERVICE_DURATION_PERIOD_CODE;
    L_ITEM_REC.SERVICE_DURATION             := X_SERVICE_DURATION;
    --  L_ITEM_REC.WARRANTY_VENDOR_ID := X_WARRANTY_VENDOR_ID ;
    --  L_ITEM_REC.MAX_WARRANTY_AMOUNT := X_MAX_WARRANTY_AMOUNT ;
    --  L_ITEM_REC.RESPONSE_TIME_PERIOD_CODE := X_RESPONSE_TIME_PERIOD_CODE ;
    --  L_ITEM_REC.RESPONSE_TIME_VALUE := X_RESPONSE_TIME_VALUE ;
    --  L_ITEM_REC.NEW_REVISION_CODE := X_NEW_REVISION_CODE ;
    L_ITEM_REC.INVOICEABLE_ITEM_FLAG         := X_INVOICEABLE_ITEM_FLAG;
    L_ITEM_REC.TAX_CODE                      := X_TAX_CODE;
    L_ITEM_REC.INVOICE_ENABLED_FLAG          := X_INVOICE_ENABLED_FLAG;
    L_ITEM_REC.MUST_USE_APPROVED_VENDOR_FLAG := X_MUST_USE_APPROVED_VENDOR_FLA;
    --  L_ITEM_REC.REQUEST_ID := X_REQUEST_ID ;
    L_ITEM_REC.OUTSIDE_OPERATION_FLAG        := X_OUTSIDE_OPERATION_FLAG;
    L_ITEM_REC.OUTSIDE_OPERATION_UOM_TYPE    := X_OUTSIDE_OPERATION_UOM_TYPE;
    L_ITEM_REC.SAFETY_STOCK_BUCKET_DAYS      := X_SAFETY_STOCK_BUCKET_DAYS;
    L_ITEM_REC.AUTO_REDUCE_MPS               := X_AUTO_REDUCE_MPS;
    L_ITEM_REC.COSTING_ENABLED_FLAG          := X_COSTING_ENABLED_FLAG;
    L_ITEM_REC.AUTO_CREATED_CONFIG_FLAG      := X_AUTO_CREATED_CONFIG_FLAG;
    L_ITEM_REC.CYCLE_COUNT_ENABLED_FLAG      := X_CYCLE_COUNT_ENABLED_FLAG;
    L_ITEM_REC.ITEM_TYPE                     := X_ITEM_TYPE;
    L_ITEM_REC.MODEL_CONFIG_CLAUSE_NAME      := X_MODEL_CONFIG_CLAUSE_NAME;
    L_ITEM_REC.SHIP_MODEL_COMPLETE_FLAG      := X_SHIP_MODEL_COMPLETE_FLAG;
    L_ITEM_REC.MRP_PLANNING_CODE             := X_MRP_PLANNING_CODE;
    L_ITEM_REC.RETURN_INSPECTION_REQUIREMENT := X_RETURN_INSPECTION_REQUIREMEN;
    L_ITEM_REC.ATO_FORECAST_CONTROL          := X_ATO_FORECAST_CONTROL;
    L_ITEM_REC.RELEASE_TIME_FENCE_CODE       := X_RELEASE_TIME_FENCE_CODE;
    L_ITEM_REC.RELEASE_TIME_FENCE_DAYS       := X_RELEASE_TIME_FENCE_DAYS;
    L_ITEM_REC.CONTAINER_ITEM_FLAG           := X_CONTAINER_ITEM_FLAG;
    L_ITEM_REC.VEHICLE_ITEM_FLAG             := X_VEHICLE_ITEM_FLAG;
    L_ITEM_REC.MAXIMUM_LOAD_WEIGHT           := X_MAXIMUM_LOAD_WEIGHT;
    L_ITEM_REC.MINIMUM_FILL_PERCENT          := X_MINIMUM_FILL_PERCENT;
    L_ITEM_REC.CONTAINER_TYPE_CODE           := X_CONTAINER_TYPE_CODE;
    L_ITEM_REC.INTERNAL_VOLUME               := X_INTERNAL_VOLUME;
    --  L_ITEM_REC.WH_UPDATE_DATE := X_WH_UPDATE_DATE ;
    L_ITEM_REC.PRODUCT_FAMILY_ITEM_ID         := X_PRODUCT_FAMILY_ITEM_ID;
    L_ITEM_REC.GLOBAL_ATTRIBUTE_CATEGORY      := X_GLOBAL_ATTRIBUTE_CATEGORY;
    L_ITEM_REC.GLOBAL_ATTRIBUTE1              := X_GLOBAL_ATTRIBUTE1;
    L_ITEM_REC.GLOBAL_ATTRIBUTE2              := X_GLOBAL_ATTRIBUTE2;
    L_ITEM_REC.GLOBAL_ATTRIBUTE3              := X_GLOBAL_ATTRIBUTE3;
    L_ITEM_REC.GLOBAL_ATTRIBUTE4              := X_GLOBAL_ATTRIBUTE4;
    L_ITEM_REC.GLOBAL_ATTRIBUTE5              := X_GLOBAL_ATTRIBUTE5;
    L_ITEM_REC.GLOBAL_ATTRIBUTE6              := X_GLOBAL_ATTRIBUTE6;
    L_ITEM_REC.GLOBAL_ATTRIBUTE7              := X_GLOBAL_ATTRIBUTE7;
    L_ITEM_REC.GLOBAL_ATTRIBUTE8              := X_GLOBAL_ATTRIBUTE8;
    L_ITEM_REC.GLOBAL_ATTRIBUTE9              := X_GLOBAL_ATTRIBUTE9;
    L_ITEM_REC.GLOBAL_ATTRIBUTE10             := X_GLOBAL_ATTRIBUTE10;
    L_ITEM_REC.PURCHASING_TAX_CODE            := X_PURCHASING_TAX_CODE;
    L_ITEM_REC.ATTRIBUTE6                     := X_ATTRIBUTE6;
    L_ITEM_REC.ATTRIBUTE7                     := X_ATTRIBUTE7;
    L_ITEM_REC.ATTRIBUTE8                     := X_ATTRIBUTE8;
    L_ITEM_REC.ATTRIBUTE9                     := X_ATTRIBUTE9;
    L_ITEM_REC.ATTRIBUTE10                    := X_ATTRIBUTE10;
    L_ITEM_REC.ATTRIBUTE11                    := X_ATTRIBUTE11;
    L_ITEM_REC.ATTRIBUTE12                    := X_ATTRIBUTE12;
    L_ITEM_REC.ATTRIBUTE13                    := X_ATTRIBUTE13;
    L_ITEM_REC.ATTRIBUTE14                    := X_ATTRIBUTE14;
    L_ITEM_REC.ATTRIBUTE15                    := X_ATTRIBUTE15;
    L_ITEM_REC.PURCHASING_ITEM_FLAG           := X_PURCHASING_ITEM_FLAG;
    L_ITEM_REC.SHIPPABLE_ITEM_FLAG            := X_SHIPPABLE_ITEM_FLAG;
    L_ITEM_REC.CUSTOMER_ORDER_FLAG            := X_CUSTOMER_ORDER_FLAG;
    L_ITEM_REC.INTERNAL_ORDER_FLAG            := X_INTERNAL_ORDER_FLAG;
    L_ITEM_REC.INVENTORY_ITEM_FLAG            := X_INVENTORY_ITEM_FLAG;
    L_ITEM_REC.ENG_ITEM_FLAG                  := X_ENG_ITEM_FLAG;
    L_ITEM_REC.INVENTORY_ASSET_FLAG           := X_INVENTORY_ASSET_FLAG;
    L_ITEM_REC.PURCHASING_ENABLED_FLAG        := X_PURCHASING_ENABLED_FLAG;
    L_ITEM_REC.CUSTOMER_ORDER_ENABLED_FLAG    := X_CUSTOMER_ORDER_ENABLED_FLAG;
    L_ITEM_REC.INTERNAL_ORDER_ENABLED_FLAG    := X_INTERNAL_ORDER_ENABLED_FLAG;
    L_ITEM_REC.SO_TRANSACTIONS_FLAG           := X_SO_TRANSACTIONS_FLAG;
    L_ITEM_REC.MTL_TRANSACTIONS_ENABLED_FLAG  := X_MTL_TRANSACTIONS_ENABLED_FLA;
    L_ITEM_REC.STOCK_ENABLED_FLAG             := X_STOCK_ENABLED_FLAG;
    L_ITEM_REC.BOM_ENABLED_FLAG               := X_BOM_ENABLED_FLAG;
    L_ITEM_REC.BUILD_IN_WIP_FLAG              := X_BUILD_IN_WIP_FLAG;
    L_ITEM_REC.REVISION_QTY_CONTROL_CODE      := X_REVISION_QTY_CONTROL_CODE;
    L_ITEM_REC.ITEM_CATALOG_GROUP_ID          := X_ITEM_CATALOG_GROUP_ID;
    L_ITEM_REC.CATALOG_STATUS_FLAG            := X_CATALOG_STATUS_FLAG;
    L_ITEM_REC.RETURNABLE_FLAG                := X_RETURNABLE_FLAG;
    L_ITEM_REC.DEFAULT_SHIPPING_ORG           := X_DEFAULT_SHIPPING_ORG;
    L_ITEM_REC.COLLATERAL_FLAG                := X_COLLATERAL_FLAG;
    L_ITEM_REC.TAXABLE_FLAG                   := X_TAXABLE_FLAG;
    L_ITEM_REC.QTY_RCV_EXCEPTION_CODE         := X_QTY_RCV_EXCEPTION_CODE;
    L_ITEM_REC.ALLOW_ITEM_DESC_UPDATE_FLAG    := X_ALLOW_ITEM_DESC_UPDATE_FLAG;
    L_ITEM_REC.INSPECTION_REQUIRED_FLAG       := X_INSPECTION_REQUIRED_FLAG;
    L_ITEM_REC.RECEIPT_REQUIRED_FLAG          := X_RECEIPT_REQUIRED_FLAG;
    L_ITEM_REC.MARKET_PRICE                   := X_MARKET_PRICE;
    L_ITEM_REC.HAZARD_CLASS_ID                := X_HAZARD_CLASS_ID;
    L_ITEM_REC.RFQ_REQUIRED_FLAG              := X_RFQ_REQUIRED_FLAG;
    L_ITEM_REC.QTY_RCV_TOLERANCE              := X_QTY_RCV_TOLERANCE;
    L_ITEM_REC.LIST_PRICE_PER_UNIT            := X_LIST_PRICE_PER_UNIT;
    L_ITEM_REC.UN_NUMBER_ID                   := X_UN_NUMBER_ID;
    L_ITEM_REC.PRICE_TOLERANCE_PERCENT        := X_PRICE_TOLERANCE_PERCENT;
    L_ITEM_REC.ASSET_CATEGORY_ID              := X_ASSET_CATEGORY_ID;
    L_ITEM_REC.ROUNDING_FACTOR                := X_ROUNDING_FACTOR;
    L_ITEM_REC.UNIT_OF_ISSUE                  := X_UNIT_OF_ISSUE;
    L_ITEM_REC.ENFORCE_SHIP_TO_LOCATION_CODE  := X_ENFORCE_SHIP_TO_LOCATION_COD;
    L_ITEM_REC.ALLOW_SUBSTITUTE_RECEIPTS_FLAG := X_ALLOW_SUBSTITUTE_RECEIPTS_FL;
    L_ITEM_REC.ALLOW_UNORDERED_RECEIPTS_FLAG  := X_ALLOW_UNORDERED_RECEIPTS_FLA;
    L_ITEM_REC.ALLOW_EXPRESS_DELIVERY_FLAG    := X_ALLOW_EXPRESS_DELIVERY_FLAG;
    L_ITEM_REC.DAYS_EARLY_RECEIPT_ALLOWED     := X_DAYS_EARLY_RECEIPT_ALLOWED;
    L_ITEM_REC.DAYS_LATE_RECEIPT_ALLOWED      := X_DAYS_LATE_RECEIPT_ALLOWED;
    L_ITEM_REC.RECEIPT_DAYS_EXCEPTION_CODE    := X_RECEIPT_DAYS_EXCEPTION_CODE;
    L_ITEM_REC.RECEIVING_ROUTING_ID           := X_RECEIVING_ROUTING_ID;
    L_ITEM_REC.INVOICE_CLOSE_TOLERANCE        := X_INVOICE_CLOSE_TOLERANCE;
    L_ITEM_REC.RECEIVE_CLOSE_TOLERANCE        := X_RECEIVE_CLOSE_TOLERANCE;
    L_ITEM_REC.AUTO_LOT_ALPHA_PREFIX          := X_AUTO_LOT_ALPHA_PREFIX;
    L_ITEM_REC.START_AUTO_LOT_NUMBER          := X_START_AUTO_LOT_NUMBER;
    L_ITEM_REC.LOT_CONTROL_CODE               := X_LOT_CONTROL_CODE;
    L_ITEM_REC.SHELF_LIFE_CODE                := X_SHELF_LIFE_CODE;
    L_ITEM_REC.SHELF_LIFE_DAYS                := X_SHELF_LIFE_DAYS;
    L_ITEM_REC.SERIAL_NUMBER_CONTROL_CODE     := X_SERIAL_NUMBER_CONTROL_CODE;
    L_ITEM_REC.START_AUTO_SERIAL_NUMBER       := X_START_AUTO_SERIAL_NUMBER;
    L_ITEM_REC.AUTO_SERIAL_ALPHA_PREFIX       := X_AUTO_SERIAL_ALPHA_PREFIX;
    L_ITEM_REC.SOURCE_TYPE                    := X_SOURCE_TYPE;
    L_ITEM_REC.SOURCE_ORGANIZATION_ID         := X_SOURCE_ORGANIZATION_ID;
    L_ITEM_REC.SOURCE_SUBINVENTORY            := X_SOURCE_SUBINVENTORY;
    L_ITEM_REC.EXPENSE_ACCOUNT                := X_EXPENSE_ACCOUNT;
    L_ITEM_REC.ENCUMBRANCE_ACCOUNT            := X_ENCUMBRANCE_ACCOUNT;
    L_ITEM_REC.RESTRICT_SUBINVENTORIES_CODE   := X_RESTRICT_SUBINVENTORIES_CODE;
    L_ITEM_REC.UNIT_WEIGHT                    := X_UNIT_WEIGHT;
    L_ITEM_REC.WEIGHT_UOM_CODE                := X_WEIGHT_UOM_CODE;
    L_ITEM_REC.VOLUME_UOM_CODE                := X_VOLUME_UOM_CODE;
    L_ITEM_REC.UNIT_VOLUME                    := X_UNIT_VOLUME;
    L_ITEM_REC.RESTRICT_LOCATORS_CODE         := X_RESTRICT_LOCATORS_CODE;
    L_ITEM_REC.LOCATION_CONTROL_CODE          := X_LOCATION_CONTROL_CODE;
    L_ITEM_REC.SHRINKAGE_RATE                 := X_SHRINKAGE_RATE;
    L_ITEM_REC.ACCEPTABLE_EARLY_DAYS          := X_ACCEPTABLE_EARLY_DAYS;
    L_ITEM_REC.PLANNING_TIME_FENCE_CODE       := X_PLANNING_TIME_FENCE_CODE;
    L_ITEM_REC.DEMAND_TIME_FENCE_CODE         := X_DEMAND_TIME_FENCE_CODE;
    L_ITEM_REC.LEAD_TIME_LOT_SIZE             := X_LEAD_TIME_LOT_SIZE;
    L_ITEM_REC.STD_LOT_SIZE                   := X_STD_LOT_SIZE;
    L_ITEM_REC.CUM_MANUFACTURING_LEAD_TIME    := X_CUM_MANUFACTURING_LEAD_TIME;
    L_ITEM_REC.OVERRUN_PERCENTAGE             := X_OVERRUN_PERCENTAGE;
    L_ITEM_REC.MRP_CALCULATE_ATP_FLAG         := X_MRP_CALCULATE_ATP_FLAG;
    L_ITEM_REC.ACCEPTABLE_RATE_INCREASE       := X_ACCEPTABLE_RATE_INCREASE;
    L_ITEM_REC.ACCEPTABLE_RATE_DECREASE       := X_ACCEPTABLE_RATE_DECREASE;
    L_ITEM_REC.CUMULATIVE_TOTAL_LEAD_TIME     := X_CUMULATIVE_TOTAL_LEAD_TIME;
    L_ITEM_REC.PLANNING_TIME_FENCE_DAYS       := X_PLANNING_TIME_FENCE_DAYS;
    L_ITEM_REC.DEMAND_TIME_FENCE_DAYS         := X_DEMAND_TIME_FENCE_DAYS;
    L_ITEM_REC.END_ASSEMBLY_PEGGING_FLAG      := X_END_ASSEMBLY_PEGGING_FLAG;
    L_ITEM_REC.REPETITIVE_PLANNING_FLAG       := X_REPETITIVE_PLANNING_FLAG;
    L_ITEM_REC.PLANNING_EXCEPTION_SET         := X_PLANNING_EXCEPTION_SET;
    L_ITEM_REC.BOM_ITEM_TYPE                  := X_BOM_ITEM_TYPE;
    L_ITEM_REC.PICK_COMPONENTS_FLAG           := X_PICK_COMPONENTS_FLAG;
    L_ITEM_REC.REPLENISH_TO_ORDER_FLAG        := X_REPLENISH_TO_ORDER_FLAG;
    L_ITEM_REC.BASE_ITEM_ID                   := X_BASE_ITEM_ID;
    L_ITEM_REC.ATP_COMPONENTS_FLAG            := X_ATP_COMPONENTS_FLAG;
    L_ITEM_REC.ATP_FLAG                       := X_ATP_FLAG;
    L_ITEM_REC.FIXED_LEAD_TIME                := X_FIXED_LEAD_TIME;
    L_ITEM_REC.VARIABLE_LEAD_TIME             := X_VARIABLE_LEAD_TIME;
    L_ITEM_REC.WIP_SUPPLY_LOCATOR_ID          := X_WIP_SUPPLY_LOCATOR_ID;
    L_ITEM_REC.WIP_SUPPLY_TYPE                := X_WIP_SUPPLY_TYPE;
    L_ITEM_REC.WIP_SUPPLY_SUBINVENTORY        := X_WIP_SUPPLY_SUBINVENTORY;
    L_ITEM_REC.COST_OF_SALES_ACCOUNT          := X_COST_OF_SALES_ACCOUNT;
    L_ITEM_REC.SALES_ACCOUNT                  := X_SALES_ACCOUNT;
    L_ITEM_REC.DEFAULT_INCLUDE_IN_ROLLUP_FLAG := X_DEFAULT_INCLUDE_IN_ROLLUP_FL;
    L_ITEM_REC.INVENTORY_ITEM_STATUS_CODE     := X_INVENTORY_ITEM_STATUS_CODE;
    L_ITEM_REC.INVENTORY_PLANNING_CODE        := X_INVENTORY_PLANNING_CODE;
    L_ITEM_REC.PLANNER_CODE                   := X_PLANNER_CODE;
    L_ITEM_REC.PLANNING_MAKE_BUY_CODE         := X_PLANNING_MAKE_BUY_CODE;
    L_ITEM_REC.FIXED_LOT_MULTIPLIER           := X_FIXED_LOT_MULTIPLIER;
    L_ITEM_REC.ROUNDING_CONTROL_TYPE          := X_ROUNDING_CONTROL_TYPE;
    L_ITEM_REC.CARRYING_COST                  := X_CARRYING_COST;
    L_ITEM_REC.POSTPROCESSING_LEAD_TIME       := X_POSTPROCESSING_LEAD_TIME;
    L_ITEM_REC.PREPROCESSING_LEAD_TIME        := X_PREPROCESSING_LEAD_TIME;
    L_ITEM_REC.SUMMARY_FLAG                   := X_SUMMARY_FLAG;
    L_ITEM_REC.ENABLED_FLAG                   := X_ENABLED_FLAG;
    L_ITEM_REC.START_DATE_ACTIVE              := X_START_DATE_ACTIVE;
    L_ITEM_REC.END_DATE_ACTIVE                := X_END_DATE_ACTIVE;
    L_ITEM_REC.BUYER_ID                       := X_BUYER_ID;
    L_ITEM_REC.ACCOUNTING_RULE_ID             := X_ACCOUNTING_RULE_ID;
    L_ITEM_REC.INVOICING_RULE_ID              := X_INVOICING_RULE_ID;
    L_ITEM_REC.OVER_SHIPMENT_TOLERANCE        := X_OVER_SHIPMENT_TOLERANCE;
    L_ITEM_REC.UNDER_SHIPMENT_TOLERANCE       := X_UNDER_SHIPMENT_TOLERANCE;
    L_ITEM_REC.OVER_RETURN_TOLERANCE          := X_OVER_RETURN_TOLERANCE;
    L_ITEM_REC.UNDER_RETURN_TOLERANCE         := X_UNDER_RETURN_TOLERANCE;
    L_ITEM_REC.EQUIPMENT_TYPE                 := X_EQUIPMENT_TYPE;
    L_ITEM_REC.RECOVERED_PART_DISP_CODE       := X_RECOVERED_PART_DISP_CODE;
    L_ITEM_REC.DEFECT_TRACKING_ON_FLAG        := X_DEFECT_TRACKING_ON_FLAG;
    L_ITEM_REC.EVENT_FLAG                     := X_EVENT_FLAG;
    L_ITEM_REC.ELECTRONIC_FLAG                := X_ELECTRONIC_FLAG;
    L_ITEM_REC.DOWNLOADABLE_FLAG              := X_DOWNLOADABLE_FLAG;
    L_ITEM_REC.VOL_DISCOUNT_EXEMPT_FLAG       := X_VOL_DISCOUNT_EXEMPT_FLAG;
    L_ITEM_REC.COUPON_EXEMPT_FLAG             := X_COUPON_EXEMPT_FLAG;
    L_ITEM_REC.COMMS_NL_TRACKABLE_FLAG        := X_COMMS_NL_TRACKABLE_FLAG;
    L_ITEM_REC.ASSET_CREATION_CODE            := X_ASSET_CREATION_CODE;
    L_ITEM_REC.COMMS_ACTIVATION_REQD_FLAG     := X_COMMS_ACTIVATION_REQD_FLAG;
    L_ITEM_REC.ORDERABLE_ON_WEB_FLAG          := X_ORDERABLE_ON_WEB_FLAG;
    L_ITEM_REC.BACK_ORDERABLE_FLAG            := X_BACK_ORDERABLE_FLAG;
    L_ITEM_REC.WEB_STATUS                     := X_WEB_STATUS;
    L_ITEM_REC.INDIVISIBLE_FLAG               := X_INDIVISIBLE_FLAG;
    L_ITEM_REC.DIMENSION_UOM_CODE             := X_DIMENSION_UOM_CODE;
    L_ITEM_REC.UNIT_LENGTH                    := X_UNIT_LENGTH;
    L_ITEM_REC.UNIT_WIDTH                     := X_UNIT_WIDTH;
    L_ITEM_REC.UNIT_HEIGHT                    := X_UNIT_HEIGHT;
    L_ITEM_REC.BULK_PICKED_FLAG               := X_BULK_PICKED_FLAG;
    L_ITEM_REC.LOT_STATUS_ENABLED             := X_LOT_STATUS_ENABLED;
    L_ITEM_REC.DEFAULT_LOT_STATUS_ID          := X_DEFAULT_LOT_STATUS_ID;
    L_ITEM_REC.SERIAL_STATUS_ENABLED          := X_SERIAL_STATUS_ENABLED;
    L_ITEM_REC.DEFAULT_SERIAL_STATUS_ID       := X_DEFAULT_SERIAL_STATUS_ID;
    L_ITEM_REC.LOT_SPLIT_ENABLED              := X_LOT_SPLIT_ENABLED;
    L_ITEM_REC.LOT_MERGE_ENABLED              := X_LOT_MERGE_ENABLED;
    L_ITEM_REC.INVENTORY_CARRY_PENALTY        := X_INVENTORY_CARRY_PENALTY;
    L_ITEM_REC.OPERATION_SLACK_PENALTY        := X_OPERATION_SLACK_PENALTY;
    L_ITEM_REC.FINANCING_ALLOWED_FLAG         := X_FINANCING_ALLOWED_FLAG;
    L_ITEM_REC.EAM_ITEM_TYPE             := X_EAM_ITEM_TYPE;
    L_ITEM_REC.EAM_ACTIVITY_TYPE_CODE    := X_EAM_ACTIVITY_TYPE_CODE;
    L_ITEM_REC.EAM_ACTIVITY_CAUSE_CODE   := X_EAM_ACTIVITY_CAUSE_CODE;
    L_ITEM_REC.EAM_ACT_NOTIFICATION_FLAG := X_EAM_ACT_NOTIFICATION_FLAG;
    L_ITEM_REC.EAM_ACT_SHUTDOWN_STATUS   := X_EAM_ACT_SHUTDOWN_STATUS;
    L_ITEM_REC.DUAL_UOM_CONTROL          := X_DUAL_UOM_CONTROL;
    L_ITEM_REC.SECONDARY_UOM_CODE        := X_SECONDARY_UOM_CODE;
    L_ITEM_REC.DUAL_UOM_DEVIATION_HIGH   := X_DUAL_UOM_DEVIATION_HIGH;
    L_ITEM_REC.DUAL_UOM_DEVIATION_LOW    := X_DUAL_UOM_DEVIATION_LOW;
    -- DERIVED SERVICE ATTRIBUTE COLUMNS GET UPDATED IN INV_ITEM_API.UPDATE_ITEM_ROW.
    --L_ITEM_REC.SERVICE_ITEM_FLAG         :=  L_SERVICE_ITEM_FLAG;
    --L_ITEM_REC.VENDOR_WARRANTY_FLAG      :=  L_VENDOR_WARRANTY_FLAG;
    --L_ITEM_REC.USAGE_ITEM_FLAG           :=  L_USAGE_ITEM_FLAG;
    --
    L_ITEM_REC.CONTRACT_ITEM_TYPE_CODE  := X_CONTRACT_ITEM_TYPE_CODE;
    L_ITEM_REC.SUBSCRIPTION_DEPEND_FLAG := X_SUBSCRIPTION_DEPEND_FLAG;
    L_ITEM_REC.SERV_REQ_ENABLED_CODE     := X_SERV_REQ_ENABLED_CODE;
    L_ITEM_REC.SERV_BILLING_ENABLED_FLAG := X_SERV_BILLING_ENABLED_FLAG;
    L_ITEM_REC.SERV_IMPORTANCE_LEVEL     := X_SERV_IMPORTANCE_LEVEL;
    L_ITEM_REC.PLANNED_INV_POINT_FLAG    := X_PLANNED_INV_POINT_FLAG;
    L_ITEM_REC.LOT_TRANSLATE_ENABLED     := X_LOT_TRANSLATE_ENABLED;
    L_ITEM_REC.DEFAULT_SO_SOURCE_TYPE    := X_DEFAULT_SO_SOURCE_TYPE;
    L_ITEM_REC.CREATE_SUPPLY_FLAG        := X_CREATE_SUPPLY_FLAG;
    L_ITEM_REC.SUBSTITUTION_WINDOW_CODE  := X_SUBSTITUTION_WINDOW_CODE;
    L_ITEM_REC.SUBSTITUTION_WINDOW_DAYS  := X_SUBSTITUTION_WINDOW_DAYS;
    L_ITEM_REC.SEGMENT1           := X_SEGMENT1;
    L_ITEM_REC.SEGMENT2           := X_SEGMENT2;
    L_ITEM_REC.SEGMENT3           := X_SEGMENT3;
    L_ITEM_REC.SEGMENT4           := X_SEGMENT4;
    L_ITEM_REC.SEGMENT5           := X_SEGMENT5;
    L_ITEM_REC.SEGMENT6           := X_SEGMENT6;
    L_ITEM_REC.SEGMENT7           := X_SEGMENT7;
    L_ITEM_REC.SEGMENT8           := X_SEGMENT8;
    L_ITEM_REC.SEGMENT9           := X_SEGMENT9;
    L_ITEM_REC.SEGMENT10          := X_SEGMENT10;
    L_ITEM_REC.SEGMENT11          := X_SEGMENT11;
    L_ITEM_REC.SEGMENT12          := X_SEGMENT12;
    L_ITEM_REC.SEGMENT13          := X_SEGMENT13;
    L_ITEM_REC.SEGMENT14          := X_SEGMENT14;
    L_ITEM_REC.SEGMENT15          := X_SEGMENT15;
    L_ITEM_REC.SEGMENT16          := X_SEGMENT16;
    L_ITEM_REC.SEGMENT17          := X_SEGMENT17;
    L_ITEM_REC.SEGMENT18          := X_SEGMENT18;
    L_ITEM_REC.SEGMENT19          := X_SEGMENT19;
    L_ITEM_REC.SEGMENT20          := X_SEGMENT20;
    L_ITEM_REC.ATTRIBUTE_CATEGORY := X_ATTRIBUTE_CATEGORY;
    L_ITEM_REC.ATTRIBUTE1         := X_ATTRIBUTE1;
    L_ITEM_REC.ATTRIBUTE2         := X_ATTRIBUTE2;
    L_ITEM_REC.ATTRIBUTE3         := X_ATTRIBUTE3;
    L_ITEM_REC.ATTRIBUTE4         := X_ATTRIBUTE4;
    L_ITEM_REC.ATTRIBUTE5         := X_ATTRIBUTE5;
    L_ITEM_REC.LAST_UPDATE_DATE   := X_LAST_UPDATE_DATE;
    L_ITEM_REC.LAST_UPDATED_BY    := X_LAST_UPDATED_BY;
    L_ITEM_REC.LAST_UPDATE_LOGIN  := X_LAST_UPDATE_LOGIN;
    -- L_ITEM_REC.PROGRAM_UPDATE_DATE := X_PROGRAM_UPDATE_DATE  ;
    --  L_ITEM_REC.OBJECT_VERSION_NUMBER := X_OBJECT_VERSION_NUMBER;
    L_ITEM_REC.TRACKING_QUANTITY_IND    := X_TRACKING_QUANTITY_IND;
    L_ITEM_REC.ONT_PRICING_QTY_SOURCE   := X_ONT_PRICING_QTY_SOURCE;
    L_ITEM_REC.CONSIGNED_FLAG           := X_CONSIGNED_FLAG;
    L_ITEM_REC.ASN_AUTOEXPIRE_FLAG      := X_ASN_AUTOEXPIRE_FLAG;
    L_ITEM_REC.VMI_FORECAST_TYPE        := X_VMI_FORECAST_TYPE;
    L_ITEM_REC.EXCLUDE_FROM_BUDGET_FLAG := X_EXCLUDE_FROM_BUDGET_FLAG;
    L_ITEM_REC.DRP_PLANNED_FLAG         := X_DRP_PLANNED_FLAG;
    L_ITEM_REC.CRITICAL_COMPONENT_FLAG  := X_CRITICAL_COMPONENT_FLAG;
    L_ITEM_REC.CONTINOUS_TRANSFER       := X_CONTINOUS_TRANSFER;
    L_ITEM_REC.CONVERGENCE              := X_CONVERGENCE;
    L_ITEM_REC.DIVERGENCE               := X_DIVERGENCE;
    INV_ITEM_PVT.UPDATE_ORG_ITEMS(P_INIT_MSG_LIST    => FND_API.G_TRUE,
                                  P_COMMIT           => FND_API.G_FALSE,
                                  P_LOCK_ROWS        => FND_API.G_FALSE,
                                  P_VALIDATION_LEVEL => FND_API.G_VALID_LEVEL_FULL,
                                  P_ITEM_REC         => L_ITEM_REC,
                                  P_VALIDATE_MASTER  => FND_API.G_FALSE,
                                  X_RETURN_STATUS    => L_RETURN_STATUS,
                                  X_MSG_COUNT        => L_MSG_COUNT,
                                  X_MSG_DATA         => L_MSG_DATA);
    IF (L_RETURN_STATUS = FND_API.G_RET_STS_ERROR) THEN
      FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
      APP_EXCEPTION.RAISE_EXCEPTION;
    ELSIF (L_RETURN_STATUS = FND_API.G_RET_STS_UNEXP_ERROR) THEN
      FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
    --
    -- FINALLY, SEND MESSAGES TO DEPENDENT BUSINESS OBJECTS.
    --
    ENI_ITEMS_STAR_PKG.UPDATE_ITEMS_IN_STAR(P_API_VERSION       => 1.0,
                                            P_INIT_MSG_LIST     => FND_API.G_TRUE,
                                            P_INVENTORY_ITEM_ID => L_INVENTORY_ITEM_ID,
                                            P_ORGANIZATION_ID   => L_ORGANIZATION_ID,
                                            X_RETURN_STATUS     => L_RETURN_STATUS,
                                            X_MSG_COUNT         => L_MSG_COUNT,
                                            X_MSG_DATA          => L_MSG_DATA);
    IF (L_RETURN_STATUS = FND_API.G_RET_STS_ERROR) THEN
      FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
      APP_EXCEPTION.RAISE_EXCEPTION;
    ELSIF (L_RETURN_STATUS = FND_API.G_RET_STS_UNEXP_ERROR) THEN
      FND_MESSAGE.SET_ENCODED(L_MSG_DATA);
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
    \*
      UPDATE MTL_SYSTEM_ITEMS_B
      SET
        ...
      WHERE  INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
        AND  ORGANIZATION_ID = X_ORGANIZATION_ID ;
      IF (SQL%NOTFOUND) THEN
        RAISE NO_DATA_FOUND;
      END IF;
      UPDATE MTL_SYSTEM_ITEMS_TL
      SET
        DESCRIPTION = X_DESCRIPTION,
        LAST_UPDATE_DATE = X_LAST_UPDATE_DATE,
        LAST_UPDATED_BY = X_LAST_UPDATED_BY,
        LAST_UPDATE_LOGIN = X_LAST_UPDATE_LOGIN,
        SOURCE_LANG = USERENV('LANG')
      WHERE  INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
        AND  ORGANIZATION_ID = X_ORGANIZATION_ID
        AND  USERENV('LANG') IN (LANGUAGE, SOURCE_LANG) ;
      IF (SQL%NOTFOUND) THEN
        RAISE NO_DATA_FOUND;
      END IF;
    *\
  END UPDATE_ROW;
  --  ------------------ DELETE_ROW -------------------
  PROCEDURE DELETE_ROW(X_INVENTORY_ITEM_ID IN NUMBER,
                       X_ORGANIZATION_ID   IN NUMBER) IS
  BEGIN
    -- DELETE_ROW CANNOT BE USED TO DELETE ITEM RECORDS.
    RAISE_APPLICATION_ERROR(-20000,
                            'CANNOT DELETE ITEM USING MTL_SYSTEM_ITEMS_PKG.DELETE_ROW');
    \*
      DELETE FROM MTL_SYSTEM_ITEMS_TL
      WHERE  INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
        AND  ORGANIZATION_ID = X_ORGANIZATION_ID ;
      IF (SQL%NOTFOUND) THEN
        RAISE NO_DATA_FOUND;
      END IF;
      DELETE FROM MTL_SYSTEM_ITEMS_B
      WHERE  INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
        AND  ORGANIZATION_ID = X_ORGANIZATION_ID ;
      IF (SQL%NOTFOUND) THEN
        RAISE NO_DATA_FOUND;
      END IF;
    *\
  END DELETE_ROW;
  -- ------------------- ADD_LANGUAGE --------------------
  PROCEDURE ADD_LANGUAGE IS
  BEGIN
    DELETE FROM MTL_SYSTEM_ITEMS_TL T
     WHERE NOT EXISTS (SELECT NULL
              FROM MTL_SYSTEM_ITEMS_B B
             WHERE B.INVENTORY_ITEM_ID = T.INVENTORY_ITEM_ID
               AND B.ORGANIZATION_ID = T.ORGANIZATION_ID);
    UPDATE MTL_SYSTEM_ITEMS_TL T
       SET (DESCRIPTION, LONG_DESCRIPTION) =
           (SELECT B.DESCRIPTION, B.LONG_DESCRIPTION
              FROM MTL_SYSTEM_ITEMS_TL B
             WHERE B.INVENTORY_ITEM_ID = T.INVENTORY_ITEM_ID
               AND B.ORGANIZATION_ID = T.ORGANIZATION_ID
               AND B.LANGUAGE = T.SOURCE_LANG)
     WHERE (T.INVENTORY_ITEM_ID, T.ORGANIZATION_ID, T.LANGUAGE) IN
           (SELECT SUBT.INVENTORY_ITEM_ID,
                   SUBT.ORGANIZATION_ID,
                   SUBT.LANGUAGE
              FROM MTL_SYSTEM_ITEMS_TL SUBB, MTL_SYSTEM_ITEMS_TL SUBT
             WHERE SUBB.INVENTORY_ITEM_ID = SUBT.INVENTORY_ITEM_ID
               AND SUBB.ORGANIZATION_ID = SUBT.ORGANIZATION_ID
               AND SUBB.LANGUAGE = SUBT.SOURCE_LANG
               AND ((SUBB.DESCRIPTION <> SUBT.DESCRIPTION OR
                   (SUBB.DESCRIPTION IS NULL AND
                   SUBT.DESCRIPTION IS NOT NULL) OR
                   (SUBB.DESCRIPTION IS NOT NULL AND
                   SUBT.DESCRIPTION IS NULL)) OR
                   (SUBB.LONG_DESCRIPTION <> SUBT.LONG_DESCRIPTION OR
                   (SUBB.LONG_DESCRIPTION IS NULL AND
                   SUBT.LONG_DESCRIPTION IS NOT NULL) OR
                   (SUBB.LONG_DESCRIPTION IS NOT NULL AND
                   SUBT.LONG_DESCRIPTION IS NULL))));
    INSERT INTO MTL_SYSTEM_ITEMS_TL
      (INVENTORY_ITEM_ID,
       ORGANIZATION_ID,
       DESCRIPTION,
       LONG_DESCRIPTION,
       LAST_UPDATE_DATE,
       LAST_UPDATED_BY,
       CREATION_DATE,
       CREATED_BY,
       LAST_UPDATE_LOGIN,
       LANGUAGE,
       SOURCE_LANG)
      SELECT B.INVENTORY_ITEM_ID,
             B.ORGANIZATION_ID,
             B.DESCRIPTION,
             B.LONG_DESCRIPTION,
             B.LAST_UPDATE_DATE,
             B.LAST_UPDATED_BY,
             B.CREATION_DATE,
             B.CREATED_BY,
             B.LAST_UPDATE_LOGIN,
             L.LANGUAGE_CODE,
             B.SOURCE_LANG
        FROM MTL_SYSTEM_ITEMS_TL B, FND_LANGUAGES L
       WHERE L.INSTALLED_FLAG IN ('I', 'B')
         AND B.LANGUAGE = USERENV('LANG')
         AND NOT EXISTS
       (SELECT NULL
                FROM MTL_SYSTEM_ITEMS_TL T
               WHERE T.INVENTORY_ITEM_ID = B.INVENTORY_ITEM_ID
                 AND T.ORGANIZATION_ID = B.ORGANIZATION_ID
                 AND T.LANGUAGE = L.LANGUAGE_CODE);
  END ADD_LANGUAGE;
  -- ------------------- UPDATE_NLS_TO_ORG --------------------
  PROCEDURE UPDATE_NLS_TO_ORG(X_INVENTORY_ITEM_ID IN VARCHAR2,
                              X_ORGANIZATION_ID   IN VARCHAR2,
                              X_LANGUAGE          IN VARCHAR2,
                              X_DESCRIPTION       IN VARCHAR2,
                              X_LONG_DESCRIPTION  IN VARCHAR2) IS
    CURSOR ITEM_CSR IS
      SELECT INVENTORY_ITEM_ID,
             ORGANIZATION_ID,
             LANGUAGE,
             SOURCE_LANG,
             DESCRIPTION,
             LONG_DESCRIPTION
        FROM MTL_SYSTEM_ITEMS_TL
       WHERE INVENTORY_ITEM_ID = X_INVENTORY_ITEM_ID
         AND ORGANIZATION_ID IN
             (SELECT ORGANIZATION_ID
                FROM MTL_PARAMETERS
               WHERE MASTER_ORGANIZATION_ID = X_ORGANIZATION_ID
                 AND ORGANIZATION_ID <> X_ORGANIZATION_ID)
         AND LANGUAGE = X_LANGUAGE
         FOR UPDATE OF INVENTORY_ITEM_ID;
    L_DESC_CONTROL     MTL_ITEM_ATTRIBUTES.CONTROL_LEVEL%TYPE;
    L_LONGDESC_CONTROL MTL_ITEM_ATTRIBUTES.CONTROL_LEVEL%TYPE;
  BEGIN
    BEGIN
      SELECT CONTROL_LEVEL
        INTO L_DESC_CONTROL
        FROM MTL_ITEM_ATTRIBUTES
       WHERE ATTRIBUTE_NAME = 'MTL_SYSTEM_ITEMS.DESCRIPTION';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        L_DESC_CONTROL := 0;
    END;
    BEGIN
      SELECT CONTROL_LEVEL
        INTO L_LONGDESC_CONTROL
        FROM MTL_ITEM_ATTRIBUTES
       WHERE ATTRIBUTE_NAME = 'MTL_SYSTEM_ITEMS.LONG_DESCRIPTION';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        L_LONGDESC_CONTROL := 0;
    END;
    FOR C1 IN ITEM_CSR LOOP
      IF (L_DESC_CONTROL = 1) THEN
        UPDATE MTL_SYSTEM_ITEMS_TL
           SET DESCRIPTION       = X_DESCRIPTION,
               SOURCE_LANG       = X_LANGUAGE,
               LAST_UPDATE_DATE  = SYSDATE,
               LAST_UPDATED_BY   = FND_PROFILE.VALUE('USER_ID'),
               LAST_UPDATE_LOGIN = FND_PROFILE.VALUE('LOGIN_ID')
         WHERE CURRENT OF ITEM_CSR;
      END IF;
      IF (L_LONGDESC_CONTROL = 1) THEN
        UPDATE MTL_SYSTEM_ITEMS_TL
           SET LONG_DESCRIPTION  = X_LONG_DESCRIPTION,
               SOURCE_LANG       = X_LANGUAGE,
               LAST_UPDATE_DATE  = SYSDATE,
               LAST_UPDATED_BY   = FND_PROFILE.VALUE('USER_ID'),
               LAST_UPDATE_LOGIN = FND_PROFILE.VALUE('LOGIN_ID')
         WHERE CURRENT OF ITEM_CSR;
      END IF;
    END LOOP;
    RETURN;
  END UPDATE_NLS_TO_ORG;
*/
END XXTRINITI_CREATE_ITEMS_PKG;