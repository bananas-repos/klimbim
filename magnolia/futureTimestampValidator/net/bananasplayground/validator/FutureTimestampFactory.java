package net.bananasplayground.validator;

import java.time.LocalDateTime;

import javax.inject.Inject;

import com.vaadin.data.Validator;

import info.magnolia.ui.field.AbstractFieldValidatorFactory;

/**
 * @see net.bananasplayground.validator.FutureTimestampDefinition
 */

public class FutureTimestampFactory extends AbstractFieldValidatorFactory<FutureTimestampDefinition, LocalDateTime> {

    @Inject
    public FutureTimestampFactory(FutureTimestampDefinition definition) {
        super(definition);
    }

    @Override
    public Validator<LocalDateTime> createValidator() {
        return new FutureTimestampValidator(getI18nErrorMessage(), definition.getTimeToAdd());
    }
}
