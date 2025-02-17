#ifndef VARIANTLISTMODEL_H
#define VARIANTLISTMODEL_H

#include "baselistmodel.h"


namespace ViewSolutions {

/**
 * @brief The VariantListModel class is universal implementation for all atomic types.
 */
class VariantListModel: public BaseListModel<QVariant>
{
    Q_OBJECT
    BASE_LIST_MODEL_DATA_PROPERTY(QVariant)

public:
    VariantListModel(QObject* ptr = nullptr): BaseListModel<QVariant>(ptr){};
};

}

#endif // VARIANTLISTMODEL_H
