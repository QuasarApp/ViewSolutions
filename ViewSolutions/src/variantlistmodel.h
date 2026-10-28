#ifndef VARIANTLISTMODEL_H
#define VARIANTLISTMODEL_H

#include "baselistmodel.h"


namespace ViewSolutions {

/**
 * @brief The VariantListModel class is universal implementation for all atomic types.
 *
 * The model is a BaseListModel<QVariant> and can store any QVariant value
 * (int, double, QString, QObject, ...).
 *
 * Example:
 * ```cpp
 * ViewSolutions::VariantListModel model;
 *
 * QList<QVariant> items;
 * items << "one" << 2 << 3.14;
 * model.setDataList(items);
 * ```
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
