package net.bananasplayground.validator;

import info.magnolia.ui.field.ConfiguredFieldValidatorDefinition;
import info.magnolia.ui.field.ValidatorType;
import lombok.Getter;
import lombok.Setter;

/**
 * Klimbim Software collection, A bag full of things
 * Copyright (C) 2011-2023 Johannes 'Banana' Keßler
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * Checks if datetime selection is >= now+timeToAdd
 *
 * works on LocalDateTime object
 *
 * timeToAdd time in lowercase, date uppercase
 * timeToAdd: 1h|2D
 *
 * futureDate:
 *  $type: futureTimestamp
 *  timeToAdd: 1h
 *  errorMessage: bla
 *
 */

@Getter
@Setter
@ValidatorType("futureTimestamp")
public class FutureTimestampDefinition extends ConfiguredFieldValidatorDefinition {

    private String timeToAdd;

    public FutureTimestampDefinition() {
        setFactoryClass(FutureTimestampFactory.class);
    }
}
