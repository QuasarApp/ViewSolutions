#ifndef VARIANTLISTMODEL_H
#define VARIANTLISTMODEL_H

#include "viewsolutions_global.h"
#include "baselistmodel.h"


namespace ViewSolutions {

/**
 * @brief The VariantListModel class is universal implementation for all atomic types.
 */
class VIEWSOLUTION_EXPORT VariantListModel: public BaseListModel<QVariant>
{
    Q_OBJECT
    BASE_LIST_MODEL_DATA_PROPERTY(QVariant)

public:
    VariantListModel(QObject* ptr = nullptr): BaseListModel<QVariant>(ptr){};
};

}

#endif // VARIANTLISTMODEL_H
